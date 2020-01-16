pragma solidity ^0.4.24;


contract SafeMath {
    function safeAdd(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}



contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract Owned {
    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed _from, address indexed _to);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}


contract EgroPostIco is ERC20Interface, Owned, SafeMath {
    
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint  totalsupply;
    uint public presale_token;
    uint public total_crowdsale_token;
    uint256 public constant tokenExchangeRate = 100; // 100 tokens per 1 wei
    
    struct presale{
        uint startDate;
        uint endDate;
        uint pretoken;
        uint discount;
    }
    
    struct crowdsale{
        uint crowd_startdate;
        uint hardcap;
        uint softcap;
        uint crowd_enddate;
    }
    
  
    presale[] public presale_array;
    
    crowdsale public crowdsale_obj;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    constructor(uint _totalSupply) public {
        symbol = "DEMO";
        name = "CHANGE NAME";
        decimals = 18;
        totalsupply = _totalSupply;
    }

    function start_presale(uint _startdate,uint _enddate,uint token_for_presale,uint _discount) public onlyOwner{
        
        if(_startdate <= _enddate && _startdate > now && token_for_presale < totalsupply)
        {
            for(uint start=0; start < presale_array.length; start++)
            {
                if(presale_array[start].endDate >= _startdate || presale_array[start].discount <= _discount)
                {   
                    revert("Another Sale is running");
                }
            }
            
            presale memory p= presale(_startdate,_enddate,token_for_presale,_discount);
            presale_array.push(p);
            presale_token += token_for_presale;
            total_crowdsale_token = totalsupply-presale_token;
        }
        else
        {
            revert("Presale not set");
        }
    }
    
    function start_crowdsale(uint _startdate,uint _enddate,uint _softcap) public onlyOwner{
        if(_startdate <= _enddate && _startdate > now && _softcap < total_crowdsale_token)
        {
            crowdsale_obj.crowd_startdate = _startdate;
            crowdsale_obj.crowd_enddate = _enddate;
            crowdsale_obj.softcap = _softcap;
            crowdsale_obj.hardcap = total_crowdsale_token - _softcap;
        }
        else
        {
            revert("Crowdasale not set");
        }
    }
    
    function totalSupply() public constant returns (uint) {
        return totalsupply  - balances[address(0)];
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function pay (uint256 _token,uint256 _amount) public payable {
        uint256 amount =safeDiv(_token,tokenExchangeRate);
        
        if(amount == _amount){
            for (uint i=0; i < presale_array.length; i++){
           
                if (now >= presale_array[i].startDate && now <=presale_array[i].endDate) {
                    uint256 discounted_pretoken = _token + _token * presale_array[i].discount / 100;
                    if(_token <= presale_array[i].pretoken){
                        presale_array[i].pretoken -= discounted_pretoken;
                        balances[msg.sender] = safeAdd(balances[msg.sender], discounted_pretoken);
                        return;
                    }
                    else{
                        revert();
                    }
                }
            }
                
            if(now >= crowdsale_obj.crowd_startdate && now <= crowdsale_obj.crowd_enddate) {
                
                require(_token < total_crowdsale_token);
                
                balances[msg.sender] = safeAdd(balances[msg.sender], _token);
                if(crowdsale_obj.softcap > 0 && _token <= crowdsale_obj.softcap){
                    crowdsale_obj.softcap -= _token;
                }
                else if(crowdsale_obj.softcap == 0 && crowdsale_obj.hardcap > 0 && _token <= crowdsale_obj.hardcap){
                    crowdsale_obj.hardcap -= _token;
                }
                else{
                    revert("Check available token balances");
                }
            }
            else{
                revert("Sale is not started");
            }
         
        emit Transfer(address(0), msg.sender, _token);
        owner.transfer(_amount);
        }
        else{
            revert("Enter valid amount");
        }
    }
}
