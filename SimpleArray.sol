pragma solidity ^0.4.19;

contract SimpleArray{
    uint[] number = [1,2,3];
    uint[3] num2 ;
    function CallArray() public constant returns (uint len,uint[]){
        number.push(4);
        len = number.length;
        return (len,number);
    }
}

contract LoopArray{
    uint[] private arr1;
    
    function ArFunc(uint value) returns (uint[],uint len){
        for(uint i =1; i<=value;i++){
            arr1.push(i);
        }
        len = arr1.length;
        return (arr1,len);
    }
}
contract StringArray{
    string[] private arr2=['a','b','c','d'];
    
    function SrFunc()public constant returns (uint len,string[]){
        len = arr2.length;
        return(len,arr2);
    }
}