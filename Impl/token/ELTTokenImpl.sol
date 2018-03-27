pragma solidity ^0.4.21;

import "../token/StandardTokenExt.sol";


/**
 * ELT Token Implementation.
 *
 * This must be deployed first and then we will get the address of this contract and we will use this address to initialise 
 * ELTToken that will be used on the network
 *
 */
contract ELTToken is StandardTokenExt {

    // Token meta information
    string public name;
    string public symbol;
    uint public decimals;

    function setreleaseFinalizationDate(uint _value);
    function releaseTokenTransfer(bool _value);
    
    /** Name and symbol were updated. */
    event UpdatedTokenInformation(string newName, string newSymbol);

    function ELTToken(address _owner, string _name, string _symbol, uint _totalSupply, uint _decimals, uint _releaseFinalizationDate) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        decimals = _decimals;

        // Allocate initial balance to the owner
        balances[_owner] = _totalSupply;

        releaseFinalizationDate = _releaseFinalizationDate;
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


    /**
     * One way function to perform the final token release.
     */
    function releaseTokenTransfer(bool _value) onlyOwner public {
        released = _value;
    }

    function setreleaseFinalizationDate(uint _value) onlyOwner public {
        releaseFinalizationDate = _value;
    }
}
