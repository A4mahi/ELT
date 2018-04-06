pragma solidity ^0.4.21;

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 * Implementation for Basic Token:
 *   ERC20 and Time Vault functions
 */
import "./ERC20Token.sol";
import "../util/Owned.sol";

contract Transferrable is owned, ERC20Token {
    
    event OwnershipTransferred(address indexed _from, address indexed _to);

    function transferOwnership(address newOwner) onlyOwner public {
        transferByOwner(newOwner, balanceOf(newOwner), 0);
        owner = newOwner;
        emit OwnershipTransferred(msg.sender, newOwner);
    }

}
