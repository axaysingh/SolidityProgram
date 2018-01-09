pragma solidity ^0.4.19;

contract functions{
    string public text ='';
    int number =0;
    
    function ChangeToHello(){
        number += 1;
        text='Hello World';
    }
    
    function changeToBye(){
        number += 1;
        text ='Byee';
    }
    function CallChangeToHello(){
        ChangeToHello();
        if(number == 2){
            changeToBye();
        }
    }
}