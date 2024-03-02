// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.4;

library SafeMath {
     function mul(uint256 a, uint256 b) internal pure returns (uint256) {
          if (a == 0) {
               return 0;
          }

          uint256 c = a * b;
          require(c / a == b, "Safemath Mul overflow");

          return c;
     }

     function div(uint256 a, uint256 b) internal pure returns (uint256) {
          require(b > 0, "SafeMath div overflow");
          uint256 c = a / b;
          return c;
     }

     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
          require(b <= a, "SafeMath underflow");
          uint256 c = a - b;

          return c;
     }

     function add(uint256 a, uint256 b) internal pure returns (uint256) {
          uint256 c = a + b;
          require(c >= a, "SafeMath overflow");

          return c;
     }

     function mod(uint256 a, uint256 b) internal pure returns (uint256) {
          require(b != 0, "SafeMath underflow");
          return a % b;
     }
}