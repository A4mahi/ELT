# ELT
This is the Smart Contract that implements the Ethereum Lendo Token.  It is written in Solidity and uses a proxy relay
method of upgrading the contract.

# API
## Token Management
### Construction
| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `ELTToken`      | `address _owner, string _name, string _symbol, uint _totalSupply, uint _decimals, uint _releaseFinalizationDate, address _initialVersion` |  | Creates the Ethereum Lendo Token (ELT) | 
| `setTokenInformation`      | `string _name, string _symbol` | `bool` | Allows thet token owner to change information: Name and Symbol. | 
### Maintenance
| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `transferOwnership`      | `address newOwner` | `bool` | Change owner of token | 
| `update`      | `address newAddress` | `bool` | Change the implementation of the contract for an update in version | 
### Super User Functions

| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `transferByOwner`      | `address _to, uint _value, uint _timevault` | `bool` | This function allows the Token Owner to transfer coins to an arbitrary address | 
| `setreleaseFinalizationDate`      | `uint _value` | `bool` | Set a date from which token transfer will be unlocked | 
| `releaseTokenTransfer`      | `bool _value` | `bool` | All token transfers are blocked until you call this with true | 

## Public API
### Information
| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `allowance`      | `address _owner, address _spender` | `bool` | Determine current allowance setting | 
| `balanceOf`      | `address _to, uint _value, uint _timevault` | `uint balance` | Determine current balance | 
| `isToken`      | ` (bool weAre` | `bool weAre` | Is this a token, always return true | 
| `timeVault`      | `address _owner` | `uint timevaults` | See what the current time lock on funds is | 
| `getNow`      | | `uint _now` | Returns the value of the blockchains now 
### Operations
| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `transfer`      | `address _to, uint _value` | `bool` | Transfer tokens to an address | 
| `transfer`      | `address _to, uint _value, bytes _data` | `bool` | Transfer tokens to an address with message data | 
| `approve`      | `address _spender, uint _value` | `bool` | Approve an amount of tokens that a delegated user can transfer | 
| `increaseApproval`      | `address _spender, uint _addedValue` | `bool` | Increase the approved amount for a specific user | 
| `decreaseApproval`      | `address _spender, uint _subtractedValuet` | `bool` | Decrease the approved amount for a specific user | 
