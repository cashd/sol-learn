// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Logic {
    bool initialized;
    uint256 number;

    function initialize() public {
        require(!initialized, "already initialized");

        number = 0x42;
        initialized = true;
    }

    function setNumber(uint256 _number) public {
        number = _number;
    }

    function getNumber() public view returns (uint256) {
        return number;
    }
}
