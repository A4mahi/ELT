pragma solidity ^0.4.21;

import "./VersionedToken.sol";

/**
 * ELT Token.  All calls are delegated to the current version of the contract
 *
 */
contract ELTToken is VersionedToken {
    function ELTToken(address _owner, string _name, string _symbol, uint _totalSupply, 
        uint _decimals, uint _releaseFinalizationDate, address _initialVersion) VersionedToken(_initialVersion) {
        _initialVersion.delegatecall(msg.data);
    }
}
