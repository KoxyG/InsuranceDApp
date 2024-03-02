// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import {IERC20} from "./IERC20.sol";
import {SafeMath} from "./SafeMath.sol";


contract InsuranceToken is IERC20 {
    using SafeMath for uint256;

    string private constant _name = "Insured";
    string private constant _symbol = "IST";

    mapping(address => mapping(address => uint256)) private _allowed;

    uint256 private _totalSupply;

    /////ERRORS////
    error InsufficientToken();
    error InsufficientAllowance();
    error AddressZero();

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
    ) external override returns (bool) {
     if (recipient == address(0)) revert AddressZero();

     if (amount > _balances[msg.sender]) revert InsufficientToken();

     _balances[msg.sender] = _balances[msg.sender].sub(amount);
     _balances[recipient] = _balances[recipient].add(amount);

     emit Transfer(msg.sender, recipient, amount);
     return true;
    }

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
     return _allowed[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) external override returns (bool) {
      if (spender == address(0)) revert AddressZero();
      if (amount > _balances[msg.sender]) revert InsufficientToken();

      _allowed[msg.sender][spender] = amount;
      emit Approval(msg.sender, spender, amount);
     return true;
     
    }

     // transferFrom enables an approved spender to spend a token on behalf of the owner
    // msg.sender == spender
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {
     if (amount > _allowed[sender][msg.sender]) revert InsufficientAllowance();
     if (amount > _balances[sender]) revert InsufficientAllowance();
     if (recipient == address(0)) revert AddressZero();

     _balances[sender] = _balances[sender].sub(amount);
     _balances[recipient] = _balances[recipient].add(amount);

     _allowed[sender][msg.sender] = _allowed[sender][msg.sender].sub(amount);

     emit Transfer(msg.sender, recipient, amount);
     return true;
    }

    function _mint(address account, uint256 amount) internal {
      if (account == address(0)) revert AddressZero();

      _totalSupply = _totalSupply.add(amount);
      _balances[account] = _balances[account].add(amount);

      emit Transfer(address(0), account, amount);
    }

    function mint(address to, uint256 amount) external returns(bool) {
     //anyone can mint, to implement new features intorduce Roles
     _mint(to, amount);
     return true;
    }

    function _burn(address account, uint256 value) internal {
     if (account == address(0)) revert AddressZero();
     if (value > _balances[account]) revert InsufficientToken();

     _balances[account] = _balances[account].sub(value);
     _totalSupply = _totalSupply.sub(value);
    }

    function burn(address from, uint256 amount) external returns(bool) {
     _burn(from, amount);
     return true;
    }
}
