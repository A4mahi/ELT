pragma solidity ^0.4.21;

// ----------------------------------------------------------------------------
// ERC Token Standard #223 Interface
// https://github.com/Dexaran/ERC223-token-standard/token/ERC223/ERC223_interface.sol
// ----------------------------------------------------------------------------
contract ERC223Interface {
    uint public totalSupply;
    function transfer(address to, uint value, bytes data) public returns (bool success);
    event Transfer(address indexed from, address indexed to, uint value, bytes data);
}
