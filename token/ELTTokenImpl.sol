pragma solidity ^0.4.21;

import "../token/StandardTokenExt.sol";

/**
 * ELT Token Implementation.
 *
 * This must be deployed first and then we will get the address of this contract and we will use this address to initialise 
 * ELTToken that will be used on the network
 *
 */
contract ELTTokenImpl is StandardTokenExt {
    /** Name and symbol were updated. */
    event UpdatedTokenInformation(string newName, string newSymbol);

    string public name;
    string public symbol;
    bool private adminReturnStatus ;

    /**
     * One way function to perform the final token release.
     */
    function releaseTokenTransfer(bool _value) onlyOwner public {
        released = _value;
    }

    function setGlobalTimeVault(uint _globalTimeVaultOpeningTime) onlyOwner public {
        globalTimeVault = _globalTimeVaultOpeningTime;
    }

    /*
     * This function is included to allow our token to be future proof.
     * If we need extra functionality that is not included in the base token then we can add a pseudo function here
     * 
     * functionName - the name of the pseudo function we want to exectute
     * p1 to p3 - three string parameters passed to the function
     * 
     * We will implement a switch statement (multiple if;then;else blocks) based on the functionName 
     * that will be used to select the implemented function
     */
    function admin(string functionName, string p1, string p2, string p3) onlyOwner public returns (bool result) {
        // Use parameters to remove warning
        adminReturnStatus = (bytes(functionName).length + bytes(p1).length + bytes(p2).length + bytes(p3).length) != 0;

        return adminReturnStatus ;
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
    function setTokenInformation(string _tokenName, string _tokenSymbol) onlyOwner public {
        name = _tokenName;
        symbol = _tokenSymbol;
        emit UpdatedTokenInformation(name, symbol);
    }
}
