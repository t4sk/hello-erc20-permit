// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract Token is ERC20, ERC20Permit {
    constructor(string memory _name, string memory _sym)
        ERC20(_name, _sym)
        ERC20Permit(_name)
    {}

    function mint(address _to, uint _amount) external {
        _mint(_to, _amount);
    } 
}