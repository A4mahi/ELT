pragma solidity ^0.4.21;

/**
 * ERC223 with added Lendo Functions for Time Vault
 */
import "../ERC20/ERC20Interface.sol";
import "../ERC223/ERC223Interface.sol";

contract TimeVaultInterface is ERC20Interface, ERC223Interface {
    function timeVault(address who) public constant returns (uint);
    function getNow() public constant returns (uint);
    function transferByOwner(address to, uint _value, uint timevault) public returns (bool);
}
