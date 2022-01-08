// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./gasTest.sol";

contract gasTestRun is gasTest {
    // 測試public, external, internal, private，繼承後呼叫時的費用
    uint[20] a;
    uint public xx;

    constructor() {
        a[10]=3;
    }

    function test_1() external returns (uint) { 
        // call public
        xx = test1(a);
        return xx;
    }

    function test_2() external returns (uint) { 
        // call external
        xx =  this.test2(a); // <-- use this.
        return xx;
    }

    function test_3() external returns (uint) { 
        // call internal
        xx =  test3(a);
        return xx;
    }

    // function test_4() external returns (uint) { 
    //     // call private
    //     xx =  test4(a); // <-- compile error
    //     return xx;
    // }
}