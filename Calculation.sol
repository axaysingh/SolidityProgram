pragma solidity ^0.4.19;

library Calculation{
    
    function Addition(uint a, uint b) public returns(uint){
        return a+b;
    }
    
    function Subtraction(int a, int b) public returns(int){
        return a-b;
    }
    
    function Multiply(uint a, uint b) public returns(uint){
        return a*b;
    }
    
    function Division(uint a, uint b) public returns(uint){
        return a/b;
    }
}