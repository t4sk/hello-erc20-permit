// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@rari-capital/solmate/src/tokens/ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("Token", "TOKEN", 18) {}

    function mint(address _to, uint _amount) external {
        _mint(_to, _amount);
    } 
}