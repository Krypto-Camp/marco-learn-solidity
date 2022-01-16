// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// interface 像是一個 API，你只是藉由這個介面去操作被呼叫的合約，
// user(contract) ---> interface ---> Google(contract)
// 就像操作瀏覽器去看 Google map，瀏覽器是 interface，
// 要注意的是，透過 interface 的操作，所有的狀態改變都是在被呼叫的合約裡 Google(contract)，
// 你需要在自己的合約 user(contract)，設定變數去接收

// contract Counter {
//     uint public count;

//     function inc() external { count += 1; }

//     function dec() external { count -= 1; }
// }

// 1. deploy Counter(0xdda...)
// 2. deploy CallInterface(0x0fC5)
// 3. CallInterface.example(0xdda...)
// 4. CallInterface(0x0fC5)'s count is 0
// 5. Counter(0xdda...)'s count is 1
// 6. fail result, we want CallInterface(0x0fC5)'s count is 1
// contract CallInterface {
//     uint public count;

//     function example(address _counter) external {
//         Counter(_counter).inc();
//     }
// }


// ----------------------------------------------------------------------------------


interface ICounter {
     function count() external view returns (uint);
     function inc() external;
}

// deploy contract Counter(0x1234)
// deploy callInterface(0x6789)
// callInterface.example(0x1234)
// callInterface(0x6789)'s count is 1
// contract Counter(0x1234)'s count is 1
contract callInterface {
    uint public count;

    function example(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}