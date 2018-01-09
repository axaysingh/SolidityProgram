pragma solidity ^0.4.19;

contract DeleteDemo{
    uint data;
    uint[] dataArray;
    
    function f() public{
        uint x = data;
        delete x;
        delete data;
        uint[] stoage = dataArray;
        delete dataArray;
    }
}