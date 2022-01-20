// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract BlindedAuction {

    // VARIABLE
    struct Bid {
        bytes32 blindedBid;
        uint deposit;
    }

    address payable public beneficiary;
    address public highestBidder;

    uint public biddingEnd;
    uint public revealEnd;

    bool public ended;

    mapping(address => Bid[]) public bids;
    mapping(address => uint) pendingReturns;


    // EVENT
    event AuctionEnded(address winner, uint hightestBid);

    
    // MODIFIER
    modifier onlyBefore(uint _time) {  
        require(block.timestamp < _time); 
        _;
    }
    modifier onlyAfter(uint _time) {
        require(block.timestamp > _time);
        _;
    }


    // init
    constructor(
        uint _biddingTime;
        uint _revealTime;
        address payable _beneficiary;
    ) {
        beneficiary = _beneficiary;
        biddingEnd = block.timestamp + _biddingTime;
        revealEnd = biddingEnd + _revealTime;
    }


    // FUNCTION
    function generateBlindedBidBytes32(uint value, bool fake) public view returns (bytes32) {
        return keccak256( abi.encodePacked(value, fake) );
    }

    function bid(bytes32 _blindedBid) public payable onlyBefore(biddingEnd) {
        bids[msg.sender].push(
            Bid({
                blindedBid: _blindedBid,
                deposit: msg.value
            }) 
        );
    }

    function reveal() {
        
    }

    function auctionEnd() public payable onlyAfter(revealEnd) {
        require(!end);
        emit AuctionEnded(highestBidder, hightestBid);
        ended = true;
        beneficiary.transfer(hightestBid);
    }

    function withdraw() public {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;

            payable(msg.sender).transfer(amount);
        }
    }

    function placeBid(address bidder, uint value) internal returns (bool success) {
        // 要小於等於，不然會用一樣的出價取代前一筆出價，這樣價格就不會往上加了
        if (value <= highestBidder) {
            return false;
        }
        if (highestBidder != address(0)) {
            pendingReturns[msg.sender] += hightestBid;
        }
        highestBidder = value;
        highestBidder = biddingEnd;

        return true;
    }



}
