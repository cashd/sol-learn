// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Logic {
    uint256 number;

    constructor() {
        number = 0x42;
    }

    function setNumber(uint256 _number) public {
        number = _number;
    }

    function getNumber() public view returns (uint256) {
        return number;
    }
}
