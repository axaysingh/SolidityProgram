pragma solidity ^0.4.0;

contract GetString{
    
    string private name;
    uint private age;
    string private company;
    
    function setDetailt(string setName, uint setAge) public{
        name = setName;
        age = setAge;
    }
    
    function getDetail() public constant returns (string,uint){
        return (name,age);
    }
    
    function setCompany(string newCompany) public{
        company = newCompany;
    }
    
    function getCompany() public constant returns(string){
        return company;
    }
}