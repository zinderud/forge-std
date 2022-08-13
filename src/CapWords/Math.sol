// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "../Math.sol";

library StdMath {
  function abs(int256 a) internal pure returns (uint256) {
    return stdMath.abs(a);
  }

  function delta(uint256 a, uint256 b) internal pure returns (uint256) {
    return stdMath.delta(a, b);
  }

  function delta(int256 a, int256 b) internal pure returns (uint256) {
    return stdMath.delta(a, b);
  }

  function percentDelta(uint256 a, uint256 b) internal pure returns (uint256) {
    return stdMath.percentDelta(a, b);
  }

  function percentDelta(int256 a, int256 b) internal pure returns (uint256) {
    return stdMath.percentDelta(a, b);
  }
}
