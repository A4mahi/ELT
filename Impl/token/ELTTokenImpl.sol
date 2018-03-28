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
    function ELTToken() public {
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
