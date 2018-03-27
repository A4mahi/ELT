pragma solidity ^0.4.21;

contract ERC223Basic {
  uint256 public totalSupply;
  function balanceOf(address who) public constant returns (uint256);
  function timeVault(address who) public constant returns (uint256);
  function getNow() public constant returns (uint256);
 
  function transfer(address to, uint256 value) public returns (bool);
  function transferByOwner(address to, uint256 _value, uint256 timevault) public returns (bool);
  
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Transfer(address indexed from, address indexed to, uint256 value, bytes _data);
}
 contract ContractReceiver {
     
    struct TKN {
        address sender;
        uint value;
        bytes data;
        bytes4 sig;
    }
    
    
    function tokenFallback(address _from, uint _value, bytes _data) public pure {
      TKN memory tkn;
      tkn.sender = _from;
      tkn.value = _value;
      tkn.data = _data;
      uint32 u = uint32(_data[3]) + (uint32(_data[2]) << 8) + (uint32(_data[1]) << 16) + (uint32(_data[0]) << 24);
      tkn.sig = bytes4(u);
      
      /* tkn variable is analogue of msg variable of Ether transaction
      *  tkn.sender is person who initiated this token transaction   (analogue of msg.sender)
      *  tkn.value the number of tokens that were sent   (analogue of msg.value)
      *  tkn.data is data of token transaction   (analogue of msg.data)
      *  tkn.sig is 4 bytes signature of function
      *  if data of token transaction is a function execution
      */
    }
}
/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
contract owned {
        address public owner;

        function owned() public {
            owner = msg.sender;
        }

        modifier onlyOwner {
            require(msg.sender == owner);
            _;
        }

        function transferOwnership(address newOwner) onlyOwner public{
            owner = newOwner;
        }
}
library SafeMath {
  function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}



/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is ERC223Basic , owned {
  using SafeMath for uint256;

  mapping(address => uint256) balances;
  mapping(address => uint256) timevault;
  mapping (address => mapping (address => uint256)) allowed;


 function transferByOwner(address _to, uint256 _value, uint256 _timevault) onlyOwner public returns (bool) {
    require(_to != address(0));
    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    timevault[_to] = _timevault;
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public constant returns (uint256 balance) {
    return balances[_owner];
  }
  function timeVault(address _owner) public constant returns (uint256 timevaluts) {
    return timevault[_owner];
  }
  function getNow() public constant returns (uint256 _now) {
    return now;
  }

}

/**
 * @title ERC23 interface
 */
contract ERC223 is ERC223Basic {
  function allowance(address owner, address spender) public constant returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @title Standard ERC23 token
 *
 * @dev Implementation of the basic standard token.
 */
contract StandardToken is ERC223, BasicToken {

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   *
   */
  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

  /**
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   */
  function increaseApproval (address _spender, uint _addedValue)
    returns (bool success) {
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  function decreaseApproval (address _spender, uint _subtractedValue)
    returns (bool success) {
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

}



/**
 * Standard EIP-20 token with an interface marker.
 *
 * @notice Interface marker is used by crowdsale contracts to validate that addresses point a good token contract.
 *
 */
contract StandardTokenExt is StandardToken {

  /* Interface declaration */
  function isToken() public constant returns (bool weAre) {
    return true;
  }
}

contract UpgradeAgent {

  uint public originalSupply;

  /** Interface marker */
  function isUpgradeAgent() public constant returns (bool) {
    return true;
  }

  function upgradeFrom(address _from, uint256 _value) public;

}
contract Versioned is owned,StandardTokenExt {
    address public currentVersion;
    address public owner;

    function Versioned(address initAddr){
        currentVersion = initAddr;
        owner = msg.sender;
    }

    function update(address newAddress) onlyOwner {
        currentVersion = newAddress;
    }

    function(){
        if(!currentVersion.delegatecall(msg.data)) throw;
    }
}
/**
 * ELT Token.
 *
 * Token supply is created in the token contract creation and allocated to owner.
 * The owner can then transfer from its supply to crowdsale participants.
 * The owner, or anybody, can burn any excessive tokens they are holding.
 *
 */
contract ELTToken is Versioned {

  // Token meta information
  string public name;
  string public symbol;
  uint public decimals;

  // Token release switch
  bool public released = false;

  // The date before the release must be finalized or upgrade path will be forced
  uint public releaseFinalizationDate;

  /** Name and symbol were updated. */
  event UpdatedTokenInformation(string newName, string newSymbol);

  function ELTToken(address _owner, string _name, string _symbol, uint _totalSupply, uint _decimals, uint _releaseFinalizationDate)  Versioned(_owner) {
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
  function setTokenInformation(string _name, string _symbol) onlyOwner public  {
    name = _name;
    symbol = _symbol;
    emit UpdatedTokenInformation(name, symbol);
  }
  function isContract(address _addr) private view returns (bool is_contract) {
		 uint length;
		 assembly 
		 {
		//retrieve the size of the code on target address, this needs assembly
			length := extcodesize(_addr)
		 }
		 return (length>0);
  }
   // Function that is called when a user or another contract wants to transfer funds .
 function transfer(address _to, uint _value, bytes _data) public returns (bool success) {
		 
    	 if(isContract(_to)) {
    			 return transferToContract(_to, _value, _data);
    	 }
    	 else {
    			 return transferToAddress(_to, _value, _data);
    	 }
    }
  function transfer(address _to, uint _value) public returns (bool success) {
		 
	 //standard function transfer similar to ERC20 transfer with no _data
	 //added due to backwards compatibility reasons
	 bytes memory empty;
	 if(isContract(_to)) 
	 {
	    return transferToContract(_to, _value, empty);
	 }
	 else 
	 {
		return transferToAddress(_to, _value, empty);
	 }
}
  function transferToAddress(address _to, uint256 _value, bytes _data) private returns (bool success) {
    require(_to != address(0));
    require(released==true);
    require(now > releaseFinalizationDate);
    if(timevault[msg.sender]!=0)
    {
        require(now > timevault[msg.sender]);
    }
    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value, _data);
    return true;
  }
   //function that is called when transaction target is a contract
 function transferToContract(address _to, uint _value, bytes _data) private returns (bool success) {
     require(_to != address(0));
     require(released==true);
     require(now > releaseFinalizationDate);
     if(timevault[msg.sender]!=0)
     {
        require(now > timevault[msg.sender]);
     }
	 if (balanceOf(msg.sender) < _value) revert();
	 balances[msg.sender] = balances[msg.sender].sub(_value);
	 balances[_to] = balances[_to].add(_value);
	 ContractReceiver receiver = ContractReceiver(_to);
	 receiver.tokenFallback(msg.sender, _value, _data);
	 emit Transfer(msg.sender, _to, _value, _data);
	 return true;
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
