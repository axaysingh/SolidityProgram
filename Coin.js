pragma solidity ^0.4.0;

contract Coin{
    address  minter;
    mapping(address => uint) balances;
    
    function Coin() public{
        minter = msg.sender;
    }
    
    function mint(address receiver, uint amount) public{
        if(msg.sender != minter) return;
        balances[receiver] += amount;
    }
    
    function send(address receiver , uint amount) public{
        if(balances[msg.sender] < amount) return;  
        balances[msg.sender] -=  amount;
        balances[receiver] +=  amount;
    }
    
    function QueryBalance(address addr)public constant returns(uint balance){
        return balances[addr];
    }
}