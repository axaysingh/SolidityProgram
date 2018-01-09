pragma solidity ^0.4.19;

contract StructExample{
    
    struct banking{
        string name;
        uint balance;
        string account;
    }
    banking Bank; //Calling Struct
    
    function CallStruct() public returns(string,uint,string){
        Bank.name = "Akshay";
        Bank.balance = 100000;
        Bank.account = "saving";
        return (Bank.name,Bank.balance,Bank.account);
    }
}