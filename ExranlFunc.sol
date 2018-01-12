pragma solidity ^0.4.19;

contract InfoFeed{
    function info() public payable returns(uint ret){
        return 42;
    }
}

contract Customer{
    InfoFeed feed;
    
    function setFeed(address addr) public{
        feed = InfoFeed(addr);
    }
    
    function setFeedEx(InfoFeed _feed) public{
        feed = _feed;
    }
    
    function callFeed() public{
        feed.info.value(10).gas(800)();
    }
}