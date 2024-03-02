// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {IERC20} from "./IERC20.sol";
import {SafeMath} from "./SafeMath.sol";


contract InsuranceToken is IERC20 {
    using SafeMath for uint256;

    string private constant _name = "Insured";
    string private constant _symbol = "IST";

    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;

    function name() external pure returns (string memory) {
        return _name;
    }

    function symbol() external pure returns (string memory) {
     return _symbol;
    }

    function decimal() external pure returns (uint8) {
     return 18;
    }

    function totalSupply() external view override returns (uint256) {
     return _totalSupply;
    }

    function balanceOf(
        address account
    ) external view override returns (uint256) {
     return _balances[account];
    }

    function transfer(
        address recipient,
        uint256 amount
    ) external override returns (bool) {}

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {}

    function approve(
        address spender,
        uint256 amount
    ) external override returns (bool) {}

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {}
}
