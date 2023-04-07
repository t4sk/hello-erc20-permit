// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol";

interface IERC20_Permit is IERC20,IERC20Permit {}

contract Vault {
    IERC20_Permit public immutable token;

    constructor(address _token) {
        token = IERC20_Permit(_token);
    }

    function deposit(uint amount) external {
        token.transferFrom(msg.sender, address(this), amount);
    }

    /*
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    )
    */
    function depositWithPermit(uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        token.permit(msg.sender, address(this), amount, deadline, v, r, s);
        token.transferFrom(msg.sender, address(this), amount);
    }
}