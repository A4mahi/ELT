pragma solidity ^0.4.21;

import "./VersionedToken.sol";
import "./ELTTokenType.sol";

/**
 * ELT Token.  All calls are delegated to the current version of the contract
 *
 */
contract ELTToken is ELTTokenType, VersionedToken {
    /** Name and symbol were updated. */
    event UpdatedTokenInformation(string newName, string newSymbol);

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

    /**
     * Owner can update token information here.
     *
     * It is often useful to conceal the actual token association, until
     * the token operations, like central issuance or reissuance have been completed.
     * In this case the initial token can be supplied with empty name and symbol information.
     *
     * This function allows the token owner to rename the token after the operations
     * have been completed and then point the audience to use the token contract.
     */
    function setTokenInformation(string _name, string _symbol) onlyOwner public {
        name = _name;
        symbol = _symbol;
        emit UpdatedTokenInformation(name, symbol);
    }
}
