pragma solidity ^0.5.0;

contract DeadManSwitch {
    
    uint256 public lastCheckedBlock;
    address private owner;
    address private beneficiary;
    bool public isAlive;
    
    constructor (address _beneficiary) public {
        owner = msg.sender;
        beneficiary = _beneficiary;
        isAlive = true;
        lastCheckedBlock = block.number;
    }
    
    modifier onlyOwner () {
        require(msg.sender == owner);
        _;
    }
    modifier onlyBeneficiary () {
        require(msg.sender == beneficiary);
        _;
    }
    
    function stillAlive() public onlyOwner {
        lastCheckedBlock = block.number;
    }
    
    function isDead() public{
        require ((block.number - lastCheckedBlock) >= 10, "Owner is still alive.");
        isAlive = false;
    }
    
    function getBalance() internal view onlyBeneficiary returns(uint256) {
        uint256 bal = owner.balance;
        return bal;
    }
    
    function withdraw() public onlyBeneficiary payable {
        require(!isAlive, "Owner is still alive.");
        uint256 bal = getBalance();
        (bool success, ) = msg.sender.call.value(bal)("");
        require(success, "Withdraw transfer failed.");
        
    }
    
    
}