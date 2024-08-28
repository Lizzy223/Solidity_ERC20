// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "./LizzieToken.sol";

contract MyToken is LizzieToken {
    constructor()  LizzieToken("lizzietoken", "lt", 5) {
        _mint(msg.sender, 100 * 10 ** uint256(decimals));
    }

}











