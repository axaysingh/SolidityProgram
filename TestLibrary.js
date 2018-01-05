pragma solidity ^0.4.19;

import "browser/Library.sol";

contract TestLibrary {
    using InExtended for uint;
    
    function testIncrement(uint _base) returns(uint){
        return InExtended.Increment(_base);
    }
    
    function testDecrement(uint _base) returns(uint){
        return _base.Decrement();
    }
    
    function testIncrementByValue(uint _base, uint _value) returns(uint){
        return _base.IncrementByValue(_value);
    }
    
    function testDecrementByValue(uint _base, uint _value) returns(uint){
        return InExtended.DecrementByValue(_base,_value);
    }
}