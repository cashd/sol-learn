// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import '../libraries/StorageSlot.sol';

contract Proxy {
    bytes32 private constant _IMPL_SLOT =
        bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1);

    // Setter for updating impl state variable
    function setImpl(address _impl) public {
        StorageSlot.setAddressAt(_IMPL_SLOT, _impl);
    }

    // Getter for returning imple state variable
    function getImpl() public view returns (address) {
        return StorageSlot.getAddressAt(_IMPL_SLOT);
    }

    function _delegate(address impl) internal virtual {
        assembly {
            // Load free memory pointer
            let ptr := mload(0x40)

            // Copies all calldata onto the stack starting at ptr
            calldatacopy(ptr, 0, calldatasize())

            let result := delegatecall(
                gas(), // Gas
                impl, // Load state variable, .slot returns the slot address of impl
                ptr, // Write result starting at free memory pointer
                calldatasize(), // Length in bytes of calldata
                0, // A memory address to where to store the result from delegatecall
                0
            )

            // helper function to return size of return data
            let size := returndatasize()

            // copies return data of size starting at position 0 to ptr
            returndatacopy(ptr, 0, size)

            switch result
            case 0 {
                revert(ptr, size)
            }
            default {
                return(ptr, size)
            }
        }
    }

    fallback() external {
        _delegate(StorageSlot.getAddressAt(_IMPL_SLOT));
    }
}

// Questions

/* Why do we need to write a custom function in assemlby to use 
delegatecall when this is already a function in solidity? */
