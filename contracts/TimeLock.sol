// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract TimeLock {
  /*
    | Errors | 
  */
  error NotOwnerError();
  error AlreadyQueuedError(bytes32 txId);
  error TimestampNotInRangeError(uint blockTimestamp, uint timestamp);
  error NotQueuedError(bytes32 txId);
  error TimestampNotPassedError(uint blockTimestmap, uint timestamp);
  error TimestampExpiredError(uint blockTimestamp, uint expiresAt);
  error TxFailedError();

  /*
    | Events | 
  */
  event Queue (
    bytes32 indexed txId,
    address indexed target,
    uint value,
    string func,
    bytes data,
    uint timestamp
  );

  event Execute(
    bytes32 indexed txId,
    bytes32 indexed target,
    uint value,
    string func,
    bytes32 data,
    uint timestamp
  );

   event Cancel(bytes32 indexed txId);

  /*
    | Constants | 
  */
    uint public constant MIN_DELAY = 10; // seconds
    uint public constant MAX_DELAY = 1000; // seconds
    uint public constant GRACE_PERIOD = 1000; // seconds


}