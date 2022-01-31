// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract cutLeeks {

    uint[] private people;

    function _initPeople(uint _num) public {
        // 初始化韭菜，一開始都有持有比特幣

        delete people;

        for (uint _idx = 1 ; _idx <= _num ; _idx++) {
            people.push(1);
        }
    }

    function cutPeople(uint _start, uint _end) public {
        // 割韭菜

        // 防止輸入數字上下顛倒
        if (_start > _end) {
            uint temp = _start;
            _start = _end;
            _end = temp;
        }

        // 預防超出範圍
        if (_end > people.length) {
            _end = people.length;
        }

        // 如果持有比特幣就賣掉，沒有持有就買進
        _start -= 1;
        _end -= 1;
        for (uint _idx = _start ; _idx <= _end ; _idx++) {
            if (people[_idx] == 1) {
                people[_idx] = 0;
            } else if (people[_idx] == 0) {
                people[_idx] = 1;
            }
        }
    }

    function getPeople() public view returns (uint, uint[] memory) {
        // 回傳剩多少人持有比特幣

        uint total = 0;
        for (uint _i = 0 ; _i < people.length ; _i++) {
            total += people[_i];
        }
        return (total, people);
    }
    
}