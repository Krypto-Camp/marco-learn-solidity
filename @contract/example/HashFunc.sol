//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract HashFunc {
    // keccak256(bytes memory) returns (bytes32) − computes the Keccak-256 hash of the input.
    function kk() external pure returns (bytes32) {
        bytes memory text0 = "marco"; // 0x555d6c1cfefb61e02a01d08ba74ed008e02708516ff872475584f6b4e5523f9a
        return keccak256(text0);
    }

    // fail
    function kkfail(bytes memory text0) external pure returns (bytes32) {
        return keccak256(text0); // fail
    }


    // hash
    function hash(string memory text0, string memory text1) 
        external
        pure
        returns (bytes32) 
    {
        return keccak256(abi.encodePacked(text0, text1));
    }


    // encode
    function encode(string memory text0, string memory text1) 
        external
        pure 
        returns (bytes memory) 
    {
        // abi.encode("AA", "BB") != abi.encode("AAB", "B")
        return abi.encode(text0, text1);
    }
    

    // encodePacked
    function encodePacked(string memory text0, string memory text1) 
        external 
        pure 
        returns (bytes memory) 
    {
        // collision
        // encodePacked(AAA, BBB) -> AAABBB
        // encodePacked(AA, ABBB) -> AAABBB
        return abi.encodePacked(text0, text1);
    }
}


contract GuessTheMagicWord {
    bytes32 public answer =
        0x555d6c1cfefb61e02a01d08ba74ed008e02708516ff872475584f6b4e5523f9a;

    // Magic word is "marco"
    function guess(string memory _word) public view returns (bool) {
        return keccak256(abi.encodePacked(_word)) == answer;
    }
}