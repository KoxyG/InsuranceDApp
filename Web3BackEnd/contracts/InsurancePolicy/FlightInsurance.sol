// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract FlightInsurance {
     
     struct FlightPolicy {
        string name;
        uint time;
     }

     mapping(address => FlightPolicy) public insurance;
     mapping(address => uint256) public claim;

     uint256 public  monthlyPremium;
     address public owner;  // owner of the contract

     // EVENTS
     event InsuranceCreated(address indexed user, string name, uint time);

     constructor() {
     }

     function purchasePolicy() external {
          require(msg.sender != address(0), "Invalid address");
          require(msg.vale >= monthlyPremium, "Insufficient funds");
          require(premium > 0, "Premium must be greater than 0");
     }

     function createInsurance(uint256 time, string name) external {
          require(msg.sender != address(0), "Invalid address");
          require(time > block.timestamp, "time must be > current time");

          FlightPolicy storage policy = insurance[msg.sender];
          policy.name = name;
          policy.time = time;

          emit InsuranceCreated(msg.sender, name, time);
     }

     function claimInsurance() external {}

     function approveClaim(address policyholder) external {}

     function setPremium(uint256 premium) external {
          require(msg.sender == owner, "Only owner can set premium");
          monthlyPremium = premium;
     }

     function grantAccess(address user) external {
          require(user != address(0), "Invalid address");
          require(msg.sender != address(0), "Invalid address");
          require(user != owner, "Invalid address");
          owner = user;
     }

     function  destroy() external {
          require(msg.sender == owner, "Only owner can destroy contract");
          selfdestruct(owner);
     }

}