pragma solidity ^0.4.21;

/**
 * @title TimeVaultToken
 * @dev Timevault functions.
 */
import "../lendo/TimeVaultInterface.sol";
import "./ERC20Token.sol";
import "../util/Owned.sol";
import "./OwnershipTransferrable.sol";

contract TimeVaultToken is OwnershipTransferrable, TimeVaultInterface {

    function transferByOwner(address to, uint value, uint earliestReTransferTime) onlyOwner public returns (bool) {
        transfer(to, value);
        timevault[to] = earliestReTransferTime;
        return true;
    }

    function timeVault(address owner) public constant returns (uint earliestTransferTime) {
        return timevault[owner];
    }

    function getNow() public constant returns (uint blockchainTimeNow) {
        return now;
    }

}
