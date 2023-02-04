// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract EventContract{

    // organizer
    //event
    //attendee-->who buys ticket and enjoys event
    struct Event{
        address organizer;
        string name;
        uint date; // 0 1 2
        uint price;
        uint ticketCount; // 1 sec 0.5 sec
        uint ticketRemin;
    }

    mapping(uint=>Event) public events; 
    mapping(address=>mapping(uint=>uint)) public tickets;
    uint public nxtId;

    function createEvent(string memory name,uint date,uint price,uint ticketCount) public{
        require(date > block.timestamp,"events will be organized for future dates");
        require (ticketCount>0,"you can organise event only if you create more rhan 0 tickets");

// this is the mapping of uint 0 with the 1st event index and then we increment the event
//in date we write the epoch time of the event to happen which will be greater than the current date...suppose date is 24th july 
//of the event then tickets will get distributed before 24th july...
      events[nxtId]=Event(msg.sender,name,date,price,ticketCount,ticketCount);
      nxtId++;
    }

    function buysTicket(uint id,uint quantity) public payable{

        //date of event should not be 0....if date of the events[id] does not exist
        require(events[id].date!=0,"event does not exist");
        //date of event should be greater than the timestamp of buing ticket...else the event has already occured...
        require(events[id].date>block.timestamp,"event has already occured");
   }
}