pragma solidity ^0.4.19;

contract Transcation{
    
    event SenderLogger(address);
    event ValueLogger(uint);
    
    address private owner;
    
    modifier isOwner{
        require(owner == msg.sender);
        _;
    }
    
    modifier ValidValue{
        assert(msg.value >= 1 );
        _;
    }
    
    function Transcation(){
        owner = msg.sender;
    }
    
    function () payable isOwner ValidValue{
        SenderLogger(msg.sender);
        ValueLogger(msg.value);
    }
}