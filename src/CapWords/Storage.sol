// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "../Storage.sol";
import "../Vm.sol";

library StdStorageSafeLib {
  function sigs(string memory sigStr) internal pure returns (bytes4) {
    return stdStorage.sigs(sigStr);
  }

  function find(StdStorage storage self) internal returns (uint256) {
    return stdStorage.find(self);
  }

  function target(StdStorage storage self, address _target)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.target(self, _target);
  }

  function sig(StdStorage storage self, bytes4 _sig)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.sig(self, _sig);
  }

  function sig(StdStorage storage self, string memory _sig)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.sig(self, _sig);
  }

  function withKey(StdStorage storage self, address who)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.with_key(self, who);
  }

  function withKey(StdStorage storage self, uint256 amt)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.with_key(self, amt);
  }

  function withKey(StdStorage storage self, bytes32 key)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.with_key(self, key);
  }

  function depth(StdStorage storage self, uint256 _depth)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.depth(self, _depth);
  }

  function readBytes32(StdStorage storage self) internal returns (bytes32) {
    return stdStorage.read_bytes32(self);
  }

  function readBool(StdStorage storage self) internal returns (bool) {
    return stdStorage.read_bool(self);
  }

  function readAddress(StdStorage storage self) internal returns (address) {
    return stdStorage.read_address(self);
  }

  function readUint(StdStorage storage self) internal returns (uint256) {
    return stdStorage.read_uint(self);
  }

  function readInt(StdStorage storage self) internal returns (int256) {
    return stdStorage.read_int(self);
  }

  function bytesToBytes32(bytes memory b, uint256 offset)
    public
    pure
    returns (bytes32)
  {
    return stdStorage.bytesToBytes32(b, offset);
  }
}

library StdStorageLib {
  function sigs(string memory sigStr) internal pure returns (bytes4) {
    return stdStorage.sigs(sigStr);
  }

  function find(StdStorage storage self) internal returns (uint256) {
    return stdStorage.find(self);
  }

  function target(StdStorage storage self, address _target)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.target(self, _target);
  }

  function sig(StdStorage storage self, bytes4 _sig)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.sig(self, _sig);
  }

  function sig(StdStorage storage self, string memory _sig)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.sig(self, _sig);
  }

  function withKey(StdStorage storage self, address who)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.with_key(self, who);
  }

  function withKey(StdStorage storage self, uint256 amt)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.with_key(self, amt);
  }

  function withKey(StdStorage storage self, bytes32 key)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.with_key(self, key);
  }

  function depth(StdStorage storage self, uint256 _depth)
    internal
    returns (StdStorage storage)
  {
    return stdStorage.depth(self, _depth);
  }

  function checkedWrite(StdStorage storage self, address who) internal {
    return stdStorage.checked_write(self, who);
  }

  function checkedWrite(StdStorage storage self, uint256 amt) internal {
    return stdStorage.checked_write(self, amt);
  }

  function checkedWrite(StdStorage storage self, bool write) internal {
    return stdStorage.checked_write(self, write);
  }

  function checkedWrite(StdStorage storage self, bytes32 set) internal {
    return stdStorage.checked_write(self, set);
  }

  function readBytes32(StdStorage storage self) internal returns (bytes32) {
    return stdStorage.read_bytes32(self);
  }

  function readBool(StdStorage storage self) internal returns (bool) {
    return stdStorage.read_bool(self);
  }

  function readAddress(StdStorage storage self) internal returns (address) {
    return stdStorage.read_address(self);
  }

  function readUint(StdStorage storage self) internal returns (uint256) {
    return stdStorage.read_uint(self);
  }

  function readInt(StdStorage storage self) internal returns (int256) {
    return stdStorage.read_int(self);
  }

  function bytesToBytes32(bytes memory b, uint256 offset)
    public
    pure
    returns (bytes32)
  {
    return stdStorage.bytesToBytes32(b, offset);
  }
}
