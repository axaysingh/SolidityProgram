pragma solidity ^0.4.0;

contract CoinFlip{
    address owner;
    uint payPercentage = 90;
    
    event Status(string msg,address user,uint amount);
    
    function CoinFlip() payable{
        owner = msg.sender;
    }
    
    function FlipCoin() payable{
        if((block.timestamp % 2) == 0){
            if(this.balance < ((msg.value*payPercentage)/100)){
                Status("Congratulation You won!,But we dont have enough money, So we are transfering your balance",msg.sender,msg.value);
                msg.sender.transfer(this.balance);
            }
            else{
                msg.sender.transfer(msg.value *(100 + payPercentage)/100);
                Status("Congratulation You won!,We are transfering your balance",msg.sender,msg.value * (100 + payPercentage)/100);
            }
        }
        else{
            Status("We are sorry try agian to make some money!",msg.sender,msg.value);
        }
    }
    
    modifier OnlyOwner{
        if(msg.sender != owner){
            revert();
        }
        else{
            _;
        }
    }
}