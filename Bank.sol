pragma solidity ^0.4.19;

///@title SimpleBank
///@author Akshay

contract SimpleBank{
    
    mapping (address => uint) private balances;
    address private owner;
    
    event LogDepositMade(address accountAddress, uint amount);
    event status(uint indexed statusCode);
    
    function SimpleBank() public{
        owner = msg.sender;
    }
    
    function Deposit(address owner, uint amount) public returns(uint){
        if(amount > 10 ){
            balances[owner] += amount;
            LogDepositMade(msg.sender,msg.value);
            return balances[msg.sender];
        }
        else{
            return amount;
        }
        
    }
    
    function Withdraw(address owner,uint amount) public returns(uint){
        balances[owner] -= amount;
        LogDepositMade(msg.sender,msg.value);
        return balances[msg.sender];
    }
    
    function checkBalance(address owner) public  constant returns(uint balance){
        return balances[owner];
    }
    
    function() public{
        throw;
    }
}