pragma solidity ^0.5.0;

import './SafeMath.sol';
contract DeadManSwitch {
    
    using SafeMath for uint;
    
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
        uint256 blockDifference = block.number.sub(lastCheckedBlock);
        require (blockDifference >= 10, "Owner is still alive.");
        isAlive = false;
    }
    
    function getBalance() view public onlyBeneficiary returns(uint256) {
        uint256 bal = owner.balance;
        return bal;
    }
    function kill() public {
        isAlive = false;
    }
    
    function withdraw(uint256 amount) public onlyBeneficiary payable {
        require(!isAlive, "Owner is still alive.");
        uint256 bal = getBalance();
        require(amount <= bal, "Insufficient Funds." );
        (bool success, ) = msg.sender.call.value(amount)("");
        require(success, "Withdraw transfer failed.");
//        msg.sender.transfer(bal);      
    }
    
    
}