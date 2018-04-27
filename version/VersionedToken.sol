pragma solidity ^0.4.21;

/**
 * VersionedToken:
 * 
 * This contract allows our token to be upgraded and versioned.
 * 
 */

import "../util/Owned.sol";

contract VersionedToken is owned {
    address public upgradableContractAddress;

    /**
     * Constructor: 
     *  initialVersion - the address of the initial version of the implementation for the contract
     * 
     * Note that this implementation must be visible to the relay contact even though it will not be a subclass
     * do this by importing the main contract that implements it.  If the code is not visible it will not 
     * always be accessible through the delegatecall() function.  And even if it is, it will take an unlimited amount
     * of gas to process the call.
     * 
     * In our case this it is ELTTokenImpl.sol
     * e.g.
     *    import "ELTToken.sol"
     * 
     * Please note: IMPORTANT
     * do not implement any function called "update()" otherwise it will break the Versioning system
     */
    function constuctor(address initialImplementation) public {
        upgradableContractAddress = initialImplementation;
    }

    /**
     * update
     * Call to upgrade the implementation version of this constract
     *  newVersion: this is the address of the new implementation for the contract
     */
    
    function upgradeToken(address newImplementation) onlyOwner public {
        upgradableContractAddress = newImplementation;
    }

    /**
     * This is the fallback function that is called whenever a contract is called but can't find the called function.
     * In this case we delegate the call to the implementing contract ELTTokenImpl
     *
     * Instead of using delegatecall() in Solidity we use the assembly because it allows us to return values to the caller
     */
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