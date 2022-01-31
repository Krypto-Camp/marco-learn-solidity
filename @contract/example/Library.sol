// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract testMath {
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint x) internal view returns (uint) {
        for (uint i = 0; i < arr.length; i++) {
            if (arr[i] == x)
                return i;
        }
        revert("not found");
    }

    function mul(uint[] storage arr, uint x) internal returns (uint[] storage) {
        for (uint i = 0; i < arr.length; i++) {
            arr[i] *= x;
        }
        return arr;
    }
}

contract TestArray {
    using ArrayLib for uint[];
    uint[] public arr = [3,2,1];

    function testFind() external view returns (uint i) {
        // return ArrayLib.find(arr, 2);
        i = arr.find(2);
    }
    
    // [3,2,1] -> [6,4,2]
    function testMul() external returns (uint[] memory i) {
        // return ArrayLib.mul(arr, 2);
        i = arr.mul(2); 
    }
}