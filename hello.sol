// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract OrganicFoodTraceability{
    address private farmer;
    struct Fooditem{
        string name;
        uint id;
        string supplier;
        string distributer;
        string retailer;
        bool issupplied;
        bool isdistributed;
        bool isretailed;
    }
    mapping(uint=>Fooditem) Fooditems;
    constructor(){
        farmer=msg.sender;
    }
    function addfooditem(uint id,string memory name) public{
        require (farmer==msg.sender);
        Fooditem memory f = Fooditem(name,id," "," "," ",false,false,false);
        Fooditems[f.id]=f;
        }
        function addsupplied(uint id,string memory sname) public {
            require(!Fooditems[id].issupplied);
            Fooditems[id].supplier=sname;
            Fooditems[id].issupplied=true;
        }
        function adddistributer(uint id,string memory dname) public{
            require(Fooditems[id].issupplied);
            require(!Fooditems[id].isdistributed);
            Fooditems[id].distributer=dname;
            Fooditems[id].isdistributed=true;
        }
        function addretailer(uint id,string memory rname) public {
            require(Fooditems[id].isdistributed);
            require(!Fooditems[id].isretailed);
            Fooditems[id].retailer=rname;
            Fooditems[id].isretailed=true; 
        }
        function verify(uint id) public view returns (Fooditem memory){
            return Fooditems[id];
        }
}