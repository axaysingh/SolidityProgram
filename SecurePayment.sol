pragma solidity ^0.4.19;

contract Secure{
    
    address owner;
    
    event UpdateStatus(string _msg);
    event UserStatus(string _msg,address user,uint amount);
    
    function Secure(){
        owner = msg.sender;
    }
    
    function Deposite() payable{
        UserStatus('User Has Deposite Some Money',msg.sender,msg.value);    
    }
    
    function Withdraw(uint amount) OnlyOwner{
        if(owner.send(amount)){
            UpdateStatus('User Withdraw Amount');
        }
    }
    
    function kill() OnlyOwner{
        suicide(owner);
    }
    
    function GetFund() OnlyOwner constant returns(uint){
        return this.balance;
    }
    
    modifier OnlyOwner(){
        if(owner != msg.sender){
            throw;
        }
        else{
            _;
        }
    }
}