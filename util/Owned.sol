pragma solidity ^0.4.21;

/**
 * @title Owned
 * @dev To verify ownership
 */
contract owned {
    address public owner;

    function constuctor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

}
