pragma solidity ^0.4.19;

contract D{
    uint x;
    
    function D(uint a) public payable{
        x=a;
    }
}

contract C{
    D d = new D(10);
    
    function createD(uint arg) public{
        D newD = new D(arg);
    }
    
    function createAndNowD(uint agr,uint amount) public payable{
        D newD = (new D).value(amount)(agr);
    }
}