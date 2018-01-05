pragma solidity ^0.4.0;

contract GetString{
    
    string private name;
    uint private age;
    string private company;
    
    function setName(string setName, uint setAge) public {
        name = setName;
        age = setAge;
    }
    
    function getName() public constant returns (string,uint){
        return (name,age);
    }
    
    
}