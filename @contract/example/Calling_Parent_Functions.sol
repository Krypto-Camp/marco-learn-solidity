// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Calling parent functions
- direct
- super

   A
 /   \
B     C
 \   /
   D
*/

contract A {
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo");
    }

    function bar() public virtual {
        emit Log("A.bar");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo"); // logs: B.foo
        A.foo();           // logs: A.foo
    }

    function bar() public virtual override {
        emit Log("B.bar"); // logs: B.bar
        super.bar();       // logs: A.bar
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo"); // logs: C.foo
        A.foo();           // logs: A.foo
    }

    function bar() public virtual override {
        emit Log("C.bar"); // logs: C.bar
        super.bar();       // logs: A.bar
    }
}

contract D is B, C {
    function foo() public override(B, C) {
        B.foo(); // logs: B.bar
                 // logs: A.foo
    }

    function bar() public override(B, C) {
        super.bar(); // logs: C.bar
                     // logs: B.bar
                     // logs: A.bar

    }
}