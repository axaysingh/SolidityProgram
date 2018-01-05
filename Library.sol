pragma solidity ^0.4.19;

library InExtended{
    function Increment(uint _self) returns (uint){
        return _self+1;
    }
    
    function Decrement(uint _self) returns(uint){
        return _self-1;
    }
    
    function IncrementByValue(uint _self, uint _value) returns (uint){
        return _self + _value;
    }

    function DecrementByValue(uint _self, uint _value) returns (uint){
        return _self - _value;
    }
}