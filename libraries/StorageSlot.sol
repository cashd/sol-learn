// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

library StorageSlot {
    function getAddressAt(bytes32 slot) internal view returns (address a) {
        assembly {
            a := sload(slot)
        }
    }

    function setAddressAt(bytes32 slot, address _a) internal {
        assembly {
            sstore(slot, _a)
        }
    }
}
