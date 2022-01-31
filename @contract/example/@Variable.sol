// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variable {
    bytes32 public owner32;
    address public owner; // 20 bytes

    bytes16 public aa;
    bytes32 public bb;

    constructor() {
        owner = msg.sender; // 20 bytes

        // error
        // 0xcD6a42782d230D7c13A74ddec5dD140e55499Df9
        // 0x
        // owner32 = owner; 

        owner32 = bytes20(owner);

        // aa = 0x112233445566778899aabbccddeeff11;
        // bb = aa;
    }

    // uint256 public addr = uint256(uint160(address(msg.sender)));

    // bytes32 public b = 0x111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFFCCCC;

    // // 0x111122223333444455556666777788889999aAaa
    // address public byte20_to_addres = address(uint160(bytes20(b)));

    // // 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc
    // address public uint256_to_address = address(uint160(uint256(b)));

    // bytes2 public a = 0x1234;
    // uint32 public bb = uint16(a); // b will be 0x00001234

    /*
    ** uint **
    uint32 a = 0x12345678;
    uint16 b = uint16(a); // b will be 0x5678 now

    uint16 a = 0x1234;
    uint32 b = uint32(a); // b will be 0x00001234 now
    assert(a == b);

    ** bytes **
    // bytes in Solidity represents a dynamic array of bytes. It’s a shorthand for byte[]
    bytes2 a = 0x1234;
    bytes1 b = bytes1(a); // b will be 0x12

    bytes2 public a = 0x1234;
    bytes4 public b = bytes4(a); // b will be 0x12340000

    ** uint bytes **
    bytes2 a = 0x1234;
    uint32 b = uint16(a); // b will be 0x00001234
    uint32 c = uint32(bytes4(a)); // c will be 0x12340000
    uint8 d = uint8(uint16(a)); // d will be 0x34
    uint8 e = uint8(bytes1(a)); // e will be 0x12
    */

    /*
    bytes2 a = 54321; // not allowed
    bytes2 b = 0x12; // not allowed
    bytes2 c = 0x123; // not allowed
    bytes2 d = 0x1234; // fine
    bytes2 e = 0x0012; // fine
    bytes4 f = 0; // fine
    bytes4 g = 0x0; // fine

    bytes2 a = hex"1234"; // fine
    bytes2 b = "xy"; // fine
    bytes2 c = hex"12"; // not allowed
    bytes2 d = hex"123"; // not allowed
    bytes2 e = "x"; // not allowed
    bytes2 f = "xyz"; // not allowed
    */
}