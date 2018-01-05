pragma solidity ^0.4.19;

interface Regulator{
    function checkValue(uint amount) returns (bool);
    function Loan() returns(bool);
}

contract Bank is Regulator{
    
    uint private value;
    address private owner;
    
    modifier ownerfunc{
        require(owner == msg.sender);
        _;
    }
    
    function Bank(uint amount) {
        value = amount; 
        owner = msg.sender;
    }
    
    function Deposite(uint amount)  ownerfunc{
        value += amount;    
    }
    
    function Withdraw(uint amount)  ownerfunc{
        if(checkValue(amount)){
            value -=amount;
        }
    }
    
    function Balance()  returns(uint){
        return value;
    }
    
    function checkValue(uint amount) returns (bool){
        return value >= amount;
    }
    
    function Loan()  returns(bool){
        return value > 0;
    }
    
}

contract Details is Bank(10){
    string public name;
    uint public age;
    
    function SetName(string newName) {
        name = newName;
    }
    
    function getName() returns(string){
        return name;
    }
    
     function setAge(uint newAge) {
        age = newAge;
    }
    
    function getAge()  returns(uint){
        return age;
    }
    
    // function Loan() public returns (bool){return true;} Just for Understanding Abstraction

}

contract Testexception{
    
    function testAssert(){
        assert(1==2);
    }
    
    function testRequire(){
        require(2==1);
    }
    
    function testRevert(){
        revert();
    }
    
    function testThrow(){
        throw;
    }
}