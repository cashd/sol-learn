// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "hardhat/console.sol";

// Opinioned Timelock contract
// Contract executes a transaction after a wait period
contract TimeLockX {
    error NotOwner();
    error CallFailure(address target, bytes data, bytes res);

    address public owner;
    uint256 public waitTime;

    // Mapping of call hashes to block number
    mapping(bytes32 => uint256) public calls;

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    constructor(uint256 _waitTime) {
        owner = msg.sender;
        waitTime = _waitTime;
    }

    function registerCall(bytes32 callHash) external onlyOwner {
        require(calls[callHash] == 0, "Call already registered");
        calls[callHash] = block.timestamp;
    }

    function encodeCall(address[] calldata targets, bytes[] calldata calldatas)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encode(targets, calldatas));
    }

    function executeCall(address[] calldata targets, bytes[] calldata calldatas)
        external
        onlyOwner
    {
        bytes32 callHash = encodeCall(targets, calldatas);

        require(calls[callHash] != 0, "call not registered");
        require(calls[callHash] + waitTime < block.timestamp, "wait longer");
        require(targets.length == calldatas.length, "lengths must match");

        // cache length to save gas
        uint256 length = targets.length;
        for (uint256 i = 0; i < length; ) {
            (bool ok, bytes memory res) = targets[i].call(calldatas[i]);

            // Revert if only one call fails
            if (!ok) {
                revert CallFailure(targets[i], calldatas[i], res);
            }

            // unrealistic overflow since the base gas
            // since the gas block limit will always be the upper bound
            unchecked {
                i++;
            }
        }

        delete calls[callHash];
    }
}
