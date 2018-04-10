pragma solidity ^0.4.21;

/**
 * @title Transferrable
 * Implementation Transferrable tokens:
 *   This will implement the transfer of ownership and will transfer the balance of tokens to the new owner at the same time
 */
import "./TimeVaultToken.sol";

contract OwnershipTransferrable is TimeVaultToken{

    event OwnershipTransferred(address indexed _from, address indexed _to);

    function transferOwnership(address newOwner) onlyOwner public {
        transferByOwner(newOwner, balances[owner], 0);
        owner = newOwner;
        emit OwnershipTransferred(msg.sender, newOwner);
    }

}
