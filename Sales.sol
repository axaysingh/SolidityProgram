pragma solidity ^0.4.19;

contract Sales{
    address public owner;
    bool public isSold = false;
    string public salesDescription = 'Need To Sale OnePlus';
    uint public price = 2;
    
    function SalesContract(){
        owner = msg.sender;
    }
    
    function buy() payable{
        if(msg.value >= price){
            owner.transfer(this.balance);
            owner = msg.sender;
            isSold = true;
        }
        else{
            revert();
        }
    }
}