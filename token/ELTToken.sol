pragma solidity ^0.4.21;

import "./ELTTokenImpl.sol";
import "../version/VersionedToken.sol";
import "./ELTTokenType.sol";

/**
 * ELT Token Implementation.
 *
 * This must be deployed first and then we will get the address of this contract and we will use this address to initialise 
 * ELTToken that will be used on the network
 *
 */

contract ELTToken is VersionedToken, ELTTokenType {
    string public name;
    string public symbol;
    
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
