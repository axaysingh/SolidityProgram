pragma solidity ^0.4.19;

contract ArrayMemory{
    function callArray(uint len) public pure returns(uint[],uint[]){
        uint[] memory a = new uint[](8);
        g([uint(1),2,3]);
        uint[] memory b = new uint[](len);
        return (a,b);
    }
    function g(uint[3] _data) public pure {
    }
}