pragma solidity ^0.4.21;

/**
 * @title Transferrable
 * Implementation Transferrable tokens:
 *   This will implement the transfer of ownership and will transfer the balance of tokens to the new owner at the same time
 */
import "./ERC20Token.sol";
import "../util/Owned.sol";

contract OwnershipTransferrable is owned, ERC20Token {
    
    event OwnershipTransferred(address indexed _from, address indexed _to);

    function transferOwnership(address newOwner) onlyOwner public {
        transferByOwner(newOwner, balanceOf(newOwner), 0);
        owner = newOwner;
        emit OwnershipTransferred(msg.sender, newOwner);
    }

}
