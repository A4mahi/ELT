pragma solidity ^0.4.21;

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 * Implementation for Basic Token:
 *   ERC20 and Time Vault functions
 */
import "../lendo/TimeVaultInterface.sol";
import "./ERC20Token.sol";
import "../util/Owned.sol";

contract TimeVaultToken is owned, ERC20Token, TimeVaultInterface {

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

    function transferOwnership(address newOwner) onlyOwner public {
        transferByOwner(newOwner, balanceOf(newOwner), 0);
        owner = newOwner;
        OwnershipTransferred(msg.sender, newOwner);
    }


}
