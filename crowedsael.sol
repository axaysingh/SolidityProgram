pragma solidity ^0.4.0;
contract TheSharer {
 function sendHalfSum(address addrTo) payable returns (uint balance) {
 require(msg.value % 2 == 0); // Allow even numbers only
 uint balanceBefore = this.balance;
 addrTo.transfer(msg.value / 2);
 assert(this.balance == balanceBefore - msg.value / 2);
 return this.balance;
 }
}

contract C {
    function f(uint a, uint b) public view returns (uint) {
        return a * (b + 42) + now;
    }
}