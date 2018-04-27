pragma solidity ^0.4.21;

import "./ELTTokenImpl.sol";
import "../version/VersionedToken.sol";
import "./ELTTokenType.sol";


/**
 * ELT Token Implementation.
 * This must be deployed second, after the ELTTokenImpl is deployed.  It requires the 
 * address of the implementation contract to initialise.
 *
 * Deploy with a test name and symbol first and from a development address first, then call setTokenInformation(_name, _symbol)
 *
 * to update the token's symbol and name, and then call transferOwnership(newOwner) to change owner to the token owners address
 */


contract ELTToken is VersionedToken, ELTTokenType {
    string public name;
    string public symbol;

    function constuctor(address _tokenOwner, string _tokenName, string _tokenSymbol, uint _totalSupply, uint _decimals, uint _globalTimeVaultOpeningTime, address _initialImplementation) public {
        name = _tokenName;
        symbol = _tokenSymbol;
        decimals = _decimals;
        totalSupply = _totalSupply * 10**uint(decimals);
        upgradableContractAddress = _initialImplementation;
        
        // Allocate initial balance to the owner
        balances[_tokenOwner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);

        globalTimeVault = _globalTimeVaultOpeningTime;
        released = false;
    }
}
