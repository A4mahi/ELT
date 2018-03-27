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
    function transferByOwner(address _to, uint _value, uint _timevault) onlyOwner public returns (bool) {
        transfer(_to, _value);
        timevault[_to] = _timevault;
        return true;
    }

    function timeVault(address _owner) public constant returns (uint timevaluts) {
        return timevault[_owner];
    }

    function getNow() public constant returns (uint _now) {
        return now;
    }

}
