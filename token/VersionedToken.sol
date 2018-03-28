pragma solidity ^0.4.21;

/**
 * 
 */
import "../impl/util/Owned.sol";

contract VersionedToken is owned {
    address public currentVersion;

    function VersionedToken(address initAddr) public {
        currentVersion = initAddr;
    }

    function update(address newAddress) onlyOwner public {
        currentVersion = newAddress;
    }

    function() public  {
        if (!currentVersion.delegatecall(msg.data)) revert();
    }
}