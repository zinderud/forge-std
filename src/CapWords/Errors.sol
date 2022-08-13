// SPDX-License-Identifier: MIT
// Panics work for versions >=0.8.0, but we lowered the pragma to make this compatible with Test
pragma solidity >=0.6.0 <0.9.0;

import "../Errors.sol";

library StdErrors {
  bytes public constant ASSERTION =
    abi.encodeWithSignature("Panic(uint256)", 0x01);
  bytes public constant ARITHMETIC =
    abi.encodeWithSignature("Panic(uint256)", 0x11);
  bytes public constant DIVISION =
    abi.encodeWithSignature("Panic(uint256)", 0x12);
  bytes public constant ENUM_CONVERSION =
    abi.encodeWithSignature("Panic(uint256)", 0x21);
  bytes public constant ENCODE_STORAGE =
    abi.encodeWithSignature("Panic(uint256)", 0x22);
  bytes public constant POP = abi.encodeWithSignature("Panic(uint256)", 0x31);
  bytes public constant INDEX_OOB =
    abi.encodeWithSignature("Panic(uint256)", 0x32);
  bytes public constant MEM_OVERFLOW =
    abi.encodeWithSignature("Panic(uint256)", 0x41);
  bytes public constant ZERO_VAR =
    abi.encodeWithSignature("Panic(uint256)", 0x51);
}
