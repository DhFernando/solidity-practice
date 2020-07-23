pragma solidity ^0.5.11;

library Math{
    function sum(uint x , uint y) internal pure returns(uint){ return x + y ; }
    
    function minus(uint x , uint y) internal pure returns(uint){ return x - y ; }
    
    function grate(uint x , uint y) internal pure returns(bool){ return x > y ; }
    
    function multiplication(uint x , uint y) internal pure returns(uint){ return x * y ; }
}

contract Escrow{
    address buyer;
    address payable seller;
    
    mapping(address => uint) public sellerIncomes; 
    mapping(address => uint) public items;
    uint itemPrice = 1 ether;
    
    enum State {  Waiting_for_Payment , Waiting_for_Delevery , Item_Develered }
    State currentState ;
    
    
    constructor(address _buyer , address payable _seller) public{
        seller = _seller;
        buyer = _buyer;
        items[seller] = 3;
    }
    
    modifier onlyFor(address _type) { require(msg.sender == _type); _; }
    modifier inState(State _expectState) { require(currentState == _expectState); _; }
    modifier itemCount() { require( Math.grate( items[seller] , 0 ) ); _; }
    
    // buyerOnly functions
    
    function confirmPayment(uint _buyingItemCount) public onlyFor(buyer) inState(State.Waiting_for_Payment) payable {
       
        require( msg.value == Math.multiplication( _buyingItemCount , itemPrice ) );
        require( items[seller] >=  _buyingItemCount );
        
        sellerIncomes[seller] = Math.sum( sellerIncomes[seller] , msg.value );
        seller.transfer(msg.value);
        items[seller] = Math.minus( items[seller] , 1 );
        
        currentState = State.Waiting_for_Delevery;
    }
    
    function confirmDelevery() public onlyFor(buyer) inState(State.Waiting_for_Delevery) {
        
        items[buyer] = Math.sum( items[buyer] , 1 );
        
        currentState = State.Item_Develered;
    }
    
    // sellerOnly functions
    
    function sellItem()  public onlyFor(buyer) itemCount() {
        
    }
    
    function makeDelevery()  public onlyFor(buyer) itemCount() {
        
    }
    
    
    
    //1 -> seller 2-> buyer
    
    
}