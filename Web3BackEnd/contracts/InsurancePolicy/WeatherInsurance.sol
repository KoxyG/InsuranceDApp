// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IERC20} from "../Token/IERC20.sol";
import {SafeMath} from "../Token/SafeMath.sol";


contract WeatherInsurance {

     using SafeMath for uint256;

     address private Token = 0x5FbDB2315678afecb367f032d93F642f64180aa3;
     
     struct WeatherPolicy {
        address customer;
        string destination;
        uint256 arrivalTime;
        uint256 takeOffTime;
        bool isActive;
     }

     uint public totalAmountStaked;

     mapping(address => WeatherPolicy) public insurance;
     mapping(address => uint256) public claim;

     uint256 public  monthlyPremium = 3000000000000000000; // 3 USDC  (3 * 10^18)
     address public owner;  // owner of the contract

     // EVENTS
     event InsuranceCreated(address indexed user, string name, uint time);


     constructor() {
     }

     


     function purchasePolicy() external {
          require(msg.sender != address(0), "Invalid address");
          uint256 tokenBalance = IERC20(Token).balanceOf(msg.sender);
          require(tokenBalance > monthlyPremium, "You don't have enough  tokens");
          
          uint256 premium = monthlyPremium;

          (bool success) = IERC20(Token).transferFrom(msg.sender, address(this), premium);

          // stake the premium
          if (success) {
               totalAmountStaked = totalAmountStaked.add(premium);
          } else {
               revert("transfer failed");
          }
     }

     function calculateReward() external view returns(uint256) {
          uint256 reward = totalAmountStaked.mul(10).div(100);
          return reward;
     }

     function stake() external {}

     function createInsurance(uint256 arrivalTime, string memory arrivalDestination) external {
          require(msg.sender != address(0), "Invalid address");
          require(arrivalTime > block.timestamp, "time must be > current time");

          WeatherPolicy storage policy = insurance[msg.sender];
          policy.customer = msg.sender;
          policy.destination = arrivalDestination;
          policy.arrivalTime = arrivalTime;
          policy.takeOffTime = block.timestamp;
          policy.isActive = true;

          emit InsuranceCreated(msg.sender, arrivalDestination, arrivalTime);
     }

     function claimInsurance() external {}

     function approveClaim(address policyholder) external {}


     function setPremium(uint256 premium) external {
          require(msg.sender == owner, "Only owner can set premium");
          monthlyPremium = premium;
     }

     // function grantAccess(address user) external {
     //      require(user != address(0), "Invalid address");
     //      require(msg.sender != address(0), "Invalid address");
     //      require(user != owner, "Invalid address");
     //      owner = user;
     // }

     function  destroy() external {
          require(msg.sender == owner, "Only owner can destroy contract");
          selfdestruct(owner);
     }

}