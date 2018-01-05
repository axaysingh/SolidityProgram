pragma solidity ^0.4.19;

import "browser/DemoLibrary.sol";

contract AcessLibrary{
    
    address creator = msg.sender;
    using Calculation for uint;
    
    function Add(uint x, uint y) public constant returns(uint){
        return Calculation.Addition(x,y);
    }
    
    function Subtract(int x, int y) public constant returns(int){
        if(x < 0 && y < 0) {
           revert();
        }
        else{
         return Calculation.Subtraction(x,y);
        }
    }
    
    function Multiply(uint x, uint y) public constant returns(uint){
        return Calculation.Multiply(x,y);
    }
    
    function Divide(uint x, uint y) public constant returns(uint){
        if(x < y){
            revert();
        }
        else{
            return Calculation.Division(x,y);
        }
    }
    
     function kill()
    { 
        if (msg.sender == creator)
            suicide(creator);
    }
}