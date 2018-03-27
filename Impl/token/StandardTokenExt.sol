/**
 * Standard EIP-20 token with an interface marker.
 *
 * @notice Interface marker is used by crowdsale contracts to validate that addresses point a good token contract.
 *
 */
import "./StandardToken.sol";

contract StandardTokenExt is StandardToken {

    /* Interface declaration */
    function isToken() public constant returns (bool weAre) {
        return true;
    }
}

