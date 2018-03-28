pragma solidity ^0.4.21;

import "./VersionedToken.sol";
import "./ELTTokenType.sol";

/**
 * ELT Token.  All calls are delegated to the current version of the contract
 *
 */
contract ELTToken is ELTTokenType, VersionedToken {

    function ELTToken(address _owner, string _name, string _symbol, uint _totalSupply, uint _decimals, uint _releaseFinalizationDate, address _initialVersion) VersionedToken(_initialVersion) public {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        decimals = _decimals;

        // Allocate initial balance to the owner
        balances[_owner] = _totalSupply;

        releaseFinalizationDate = _releaseFinalizationDate;
        released = false;
    }
}
