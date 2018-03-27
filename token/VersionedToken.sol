/**
 * 
 */
import "../impl/util/Owned.sol";

contract VersionedToken is owned {
    address public currentVersion;

    function VersionedToken(address initAddr){
        currentVersion = initAddr;
    }

    function update(address newAddress) onlyOwner {
        currentVersion = newAddress;
    }

    function(){
        if (!currentVersion.delegatecall(msg.data)) throw;
    }
}