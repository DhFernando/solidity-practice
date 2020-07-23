pragma solidity ^0.5.11;
contract ERC20Token{
    string public name;
    mapping(address => uint256) public balances;
    
    function mint() public {
        balances[tx.origin] += 1;  
    }
}

contract SimpleSolidity {
    uint value;
    string svalue;
    enum State { waiting , Ready , Active}
    State state;
    
    // wallet
    address payable wallet;
    address public token;
    
    
    address owner;
    
    struct Person {
        string fName;
        string lName;
    }
    
    Person[] public people;
    
    event Purches(
        address indexed _buyer,
        uint256 amount
    );
    
    constructor(address payable _wallet , address _token) public {
        svalue = "string value";
        state = State.waiting;
        owner = msg.sender;
        
        wallet = _wallet;
        token = _token;
    }
    
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    function() external payable{
        buyToken();
    }
    
    function buyToken() public payable{
        // buy a token
        
        ERC20Token _token = ERC20Token(address(token));
        _token.mint();
        
    
        //sent ether to the wallet
        wallet.transfer(msg.value);
        
        emit Purches(msg.sender , 1);
        
    }
    
    function addPersons ( string memory _fName , string memory _lName ) public {
        people.push(Person(_fName , _lName));
    }
    
    function isActive(  ) public view returns(bool){
        if( state == State.Active )  return true; 
        else  return false; 
    }
    
    function mkActive () public {
        state = State.Active;
    }
    
    function setValue(string memory _svalue) public onlyOwner{
        svalue = _svalue;
    }
    
    function getValue() public view  returns(string memory){
        return svalue;
    }
}
