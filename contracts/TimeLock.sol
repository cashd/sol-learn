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

}