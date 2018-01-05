pragma solidity ^0.4.0;

contract Helper{
    function getBalance() public constant returns(uint bal){
        return this.balance;
    }
}   
    contract AddHelper{
        Helper helper;
        
        function setHelper(address a) public{
            helper = Helper(a);
        }
        
        function sendAll() public {
            helper.send(this.balance);
        }
    }