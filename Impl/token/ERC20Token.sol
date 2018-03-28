pragma solidity ^0.4.21;

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 * Implementation for Basic Token:
 *   ERC20 and Time Vault functions
 */
import "../ERC20/ERC20Interface.sol";
import "../ERC223/ERC223Interface.sol";
import "../util/ContractReceiver.sol";
import "../util/SafeMath.sol";
import "../../token/ELTTokenType.sol";

contract ERC20Token is ERC20Interface, ERC223Interface, ELTTokenType {
    using SafeMath for uint;

    function transfer(address _to, uint _value) public returns (bool success) {
        bytes memory empty;
        return transfer(_to, _value, empty);
    }

    // Function that is called when a user or another contract wants to transfer funds .
    function transfer(address _to, uint _value, bytes _data) public returns (bool success) {

        if (isContract(_to)) {
            return transferToContract(_to, _value, _data);
        }
        else {
            return transferToAddress(_to, _value, _data);
        }
    }
    
    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     *
     */
    function approve(address _spender, uint _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * @dev Function to check the amount of tokens that an owner allowed to a spender.
     * @param _owner address The address which owns the funds.
     * @param _spender address The address which will spend the funds.
     * @return A uint specifying the amount of tokens still available for the spender.
     */
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }


    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint representing the amount owned by the passed address.
    */
    function balanceOf(address _owner) public constant returns (uint balance) {
        return balances[_owner];
    }

    function isContract(address _addr) private view returns (bool is_contract) {
        uint length;
        assembly
        {
        //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        return (length > 0);
    }
    

    //function that is called when transaction target is an address
    function transferToAddress(address _to, uint _value, bytes _data) private returns (bool success) {
        transferIfRequirementsMet(_to, _value);
        emit Transfer(msg.sender, _to, _value, _data);
        return true;
    }
    
    //function that is called when transaction target is a contract
    function transferToContract(address _to, uint _value, bytes _data) private returns (bool success) {
        transferIfRequirementsMet(_to, _value);
        ContractReceiver receiver = ContractReceiver(_to);
        receiver.tokenFallback(msg.sender, _value, _data);
        emit Transfer(msg.sender, _to, _value, _data);
        return true;
    }

    function checkTransferRequirements(address _to, uint _value) private view {
        require(_to != address(0));
        require(released == true);
        require(now > releaseFinalizationDate);
        if (timevault[msg.sender] != 0)
        {
            require(now > timevault[msg.sender]);
        }
        if (balanceOf(msg.sender) < _value) revert();
    }

    function transferIfRequirementsMet(address _to, uint _value) private {
        checkTransferRequirements(_to, _value);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
    }
}
