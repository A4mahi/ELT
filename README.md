# ELT
This is the Smart Contract that implements the Lendo Ethereum Token.  It is written in Solidity and uses a proxy relay
method of upgrading the contract.

# API
## Token Management
### Construction
| Function        | Parameters |  Description  |
| ------------- |:-------------:| -----:|
| **`ELTToken`**      |  | **Creates the Ethereum Lendo Token (ELT)** | 
|       | `address _owner` |  Address of owner of the Lendo Token | 
|       | `string _name` |  Name of token: Ethereum Lendo Token | 
|       | `string _symbol` |  Symbol: ELT | 
|       | `uint _totalSupply` | Total amount of tokens to create| 
|       | `uint _decimals` | Number of decimal places precision | 
|       | `uint _globalTimeVault` | Date when tokens are to be released.   | 
|       | `address _initialImplementation` | Creates the Ethereum Lendo Token (ELT) |
 
### Maintenance
| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `setTokenInformation`      | `string _name, string _symbol` | `bool` | Allows the token owner to change token information: Name and symbol. | 
| `transferOwnership`      | `address newOwner` | `bool` | Change owner of token.  All tokens owned by current owner will be transferred to new owner during change of ownership | 
| `upgradeToken`      | `address newImplementation` | `bool` | Change the implementation of the contract for an update in version | 
### Super User Functions

| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `transferByOwner`      | `address _to, uint _value, uint _timevault` | `bool` | This function allows the token owner to distribute tokens to an arbitrary address.  The distributed tokens are locked in a time vault until it opens at the time specified by the timeVault parameter (unix timestamp) | 
| `setGlobalTimeVault`      | `uint _value` | `bool` | Set a global date from which token transfer will be unlocked.  At this time any token owner will be able to transfer tokens.  The date is specified as a unix timestamp.  **Important note**: *This global time vault works in conjunction with the global release flag below.  Both must be open to allow token transfer* | 
| `releaseTokenTransfer`      | `bool _value` | `bool` | This is a control for releasing the token transfer function.  All token transfers will remain blocked until you call this with true. **Important note**: *This global release flag works in conjunction with the global time vault above.  Both must be open to allow token transfer* | 

## Public API
### Information
| Function        | Parameters | Return | Description  |
| ------------- |:-------------:| -----:| -----:|
| `allowance`      | `address _owner, address _spender` | `bool` | Determine current allowance setting | 
| `totalSupply`      |  | Determine total supply of tokens | 
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
