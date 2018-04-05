pragma solidity ^0.4.21;

// import "../lendo/TimeVaultInterface.sol";
// import "../ERC223/ERC223Interface.sol";

/**
 * @title Owned
 * @dev To verify ownership
 */
contract owned {
    address public owner;

    function owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner public {
//        transferByOwner(newOwner, balanceOf(newOwner), 0);
        owner = newOwner;
    }
}
