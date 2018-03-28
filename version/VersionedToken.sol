pragma solidity ^0.4.21;

/**
 * 
 */

import "../util/Owned.sol";

contract VersionedToken is owned {
    address public upgradableContractAddress;

    function VersionedToken(address initialVersion) public {
        upgradableContractAddress = initialVersion;
    }

    function update(address newVersion) onlyOwner public {
        upgradableContractAddress = newVersion;
    }

    function() public {
        address upgradableContractMem = upgradableContractAddress;
        bytes memory functionCall = msg.data;

        assembly {
        // Load the first 32 bytes of the functionCall bytes array which represents the size of the bytes array
            let functionCallSize := mload(functionCall)

        // Calculate functionCallDataAddress which starts at the second 32 byte block in the functionCall bytes array
            let functionCallDataAddress := add(functionCall, 0x20)

        // delegatecall(gasAllowed, callAddress, inMemAddress, inSizeBytes, outMemAddress, outSizeBytes) returns/pushes to stack (1 on success, 0 on failure)
            let functionCallResult := delegatecall(gas, upgradableContractMem, functionCallDataAddress, functionCallSize, 0, 0)

            let freeMemAddress := mload(0x40)

            switch functionCallResult
            case 0 {
            // revert(fromMemAddress, sizeInBytes) ends execution and returns value
                revert(freeMemAddress, 0)
            }
            default {
            // returndatacopy(toMemAddress, fromMemAddress, sizeInBytes)
                returndatacopy(freeMemAddress, 0x0, returndatasize)
            // return(fromMemAddress, sizeInBytes)
                return (freeMemAddress, returndatasize)
            }
        }
    }
}