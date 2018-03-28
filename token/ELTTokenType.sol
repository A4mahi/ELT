pragma solidity ^0.4.21;

/**
 * All meta information for the Token must be defined here so that it can be accessed from both sides of proxy
 */
contract ELTTokenType {
    string public name;
    string public symbol;

    uint public decimals;
    uint public totalSupply;

    mapping(address => uint) balances;

    mapping(address => uint) timevault;
    mapping(address => mapping(address => uint)) allowed;
    
    // Token release switch
    bool public released;
    
    // The date before the release must be finalized or upgrade path will be forced
    uint public releaseFinalizationDate;
}

