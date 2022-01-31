# ethers


## import ethers
```javascript
// node.js require
const { ethers } = require("ethers")

// ES6 or TypeScript
import { ethers } from "ethers"
```


---


## RPC connect
- Provider
  - A connection to the Ethereum network
- Signer
  - Holds your private key and can sign things

## Connecting to MetaMask
```javascript
// A Web3Provider wraps a standard Web3 provider, which is
// what MetaMask injects as window.ethereum into each page
const provider = new ethers.providers.Web3Provider(window.ethereum)

// The MetaMask plugin also allows signing transactions to
// send ether and pay to change state within the blockchain.
// For this, you need the account signer...
const signer = provider.getSigner()
```

## Connecting to localhost
```javascript
// Connecting to a Ganache Node
// Or if you are running the UI version, use this instead:
// const url = "http://localhost:8545";
const url = "http://localhost:7545"
const provider = new ethers.providers.JsonRpcProvider(url) // 如果是 hardhat 本地，不用填入 url

// Getting the accounts
const signer0 = provider.getSigner(0); // 如果是 hardhat 本地，沒有 getSigner
const signer1 = provider.getSigner(1);
```


## Connecting to a Alchemy
```javascript
// provider - Alchemy
// const alchemyProvider = new ethers.providers.AlchemyProvider('rinkeby', secret.API_KEY);
const url = "http://localhost:8545";
const provider = new ethers.providers.JsonRpcProvider(url)

// signer - you
const signer = new ethers.Wallet("private key", provider)

// contract instance
const interactContract = new ethers.Contract("address", abi, signer)
```


---


## block number
```javascript
// Look up the current block number
await provider.getBlockNumber()
> 13722573
```

## get address
```javascript
await signer.getAddress()
> '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
```

## balance
```javascript
// Get the balance of an account (by address or ENS name, if supported by network)
balance = await provider.getBalance("address")
> BigNumber { _hex: '0x021e19e0c9bab2400000', _isBigNumber: true }

balance.toNumber()
> 1000000000

ethers.utils.formatEther(balance);
> 0.000000001
```

## gas price
```javascript
gasPrice = await provider.getGasPrice()
> BigNumber { _hex: '0x6fc23ac0', _isBigNumber: true } 
```

## wei -> ether
```javascript
// Often you need to format the output to something more user-friendly,
// such as in ether (instead of wei)
ethers.utils.formatEther(balance)
> '2.337132817842795605'
```

## ether -> wei
```javascript
// If a user enters a string in an input field, you may need
// to convert it from ether (as a string) to wei (as a BigNumber)
ethers.utils.parseEther("1.0")
// { BigNumber: "1000000000000000000" }
```

## Sending Ether
```javascript
// Send 1 ether to an ens name.
const tx = signer.sendTransaction({
    to: "ricmoo.firefly.eth",
    value: ethers.utils.parseEther("1.0")
});
```


---


# Connecting to the DAI Contract

## Connect
```javascript
// You can also use an ENS name for the contract address
const daiAddress = "dai.tokens.ethers.eth" // or 0x132156131...

// The ERC-20 Contract ABI, which is a common contract interface
// for tokens (this is the Human-Readable ABI format)
const daiAbi = [
  // Some details about the token
  "function name() view returns (string)",
  "function symbol() view returns (string)",

  // Get the account balance
  "function balanceOf(address) view returns (uint)",

  // Send some of your tokens to someone else
  "function transfer(address to, uint amount)",

  // An event triggered whenever anyone transfers to someone else
  "event Transfer(address indexed from, address indexed to, uint amount)"
];

// The Contract object
const daiContract = new ethers.Contract(daiAddress, daiAbi, provider);
```

##  Read Contract
```javascript
// Get the ERC-20 token name
await daiContract.name()
// 'Dai Stablecoin'

// Get the ERC-20 token symbol (for tickers and UIs)
await daiContract.symbol()
// 'DAI'

// Get the balance of an address
balance = await daiContract.balanceOf("ricmoo.firefly.eth")
// { BigNumber: "18190624174838529547383" }

// Format the DAI for displaying to the user
ethers.utils.formatUnits(balance, 18)
// '18190.624174838529547383'
```

## Write Contract
```javascript
// The DAI Contract is currently connected to the Provider,
// which is read-only. You need to connect to a Signer, so
// that you can pay to send state-changing transactions.
let privateKey = '0x0123456789012345678901234567890123456789012345678901234567890123';
let wallet = new ethers.Wallet(privateKey, provider);
const daiWithSigner = contract.connect(wallet);

// Each DAI has 18 decimal places
const dai = ethers.utils.parseUnits("1.0", 18);

// Send 1 DAI to "ricmoo.firefly.eth"
tx = await daiWithSigner.transfer("ricmoo.firefly.eth", dai);
```

## Listening to Events
```javascript
// Receive an event when ANY transfer occurs
daiContract.on("Transfer", (from, to, amount, event) => {
    console.log(`${ from } sent ${ formatEther(amount) } to ${ to}`);
    // The event object contains the verbatim log data, the
    // EventFragment and functions to fetch the block,
    // transaction and receipt and event functions
});

## Filtering Historic Events
// A filter for when a specific address receives tokens
myAddress = "0x8ba1f109551bD432803012645Ac136ddd64DBA72";
filter = daiContract.filters.Transfer(null, myAddress)
// {
//   address: 'dai.tokens.ethers.eth',
//   topics: [
//     '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
//     null,
//     '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72'
//   ]
// }

// Receive an event when that filter occurs
daiContract.on(filter, (from, to, amount, event) => {
    // The to will always be "address"
    console.log(`I got ${ formatEther(amount) } from ${ from }.`);
});
```

## Filtering Historic Events
```javascript
// Get the address of the Signer
myAddress = await signer.getAddress()
// '0x8ba1f109551bD432803012645Ac136ddd64DBA72'

// Filter for all token transfers from me
filterFrom = daiContract.filters.Transfer(myAddress, null);
// {
//   address: 'dai.tokens.ethers.eth',
//   topics: [
//     '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
//     '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72'
//   ]
// }

// Filter for all token transfers to me
filterTo = daiContract.filters.Transfer(null, myAddress);
// {
//   address: 'dai.tokens.ethers.eth',
//   topics: [
//     '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
//     null,
//     '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72'
//   ]
// }

// List all transfers sent from me a specific block range
await daiContract.queryFilter(filterFrom, 9843470, 9843480)
// [
//   {
//     address: '0x6B175474E89094C44Da98b954EedeAC495271d0F',
//     args: [
//       '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
//       '0x8B3765eDA5207fB21690874B722ae276B96260E0',
//       { BigNumber: "4750000000000000000" },
//       amount: { BigNumber: "4750000000000000000" },
//       from: '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
//       to: '0x8B3765eDA5207fB21690874B722ae276B96260E0'
//     ],
//     blockHash: '0x8462eb2fbcef5aa4861266f59ad5f47b9aa6525d767d713920fdbdfb6b0c0b78',
//     blockNumber: 9843476,
//     data: '0x00000000000000000000000000000000000000000000000041eb63d55b1b0000',
//     decode: [Function],
//     event: 'Transfer',
//     eventSignature: 'Transfer(address,address,uint256)',
//     getBlock: [Function],
//     getTransaction: [Function],
//     getTransactionReceipt: [Function],
//     logIndex: 69,
//     removeListener: [Function],
//     removed: false,
//     topics: [
//       '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
//       '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72',
//       '0x0000000000000000000000008b3765eda5207fb21690874b722ae276b96260e0'
//     ],
//     transactionHash: '0x1be23554545030e1ce47391a41098a46ff426382ed740db62d63d7676ff6fcf1',
//     transactionIndex: 81
//   },
//   {
//     address: '0x6B175474E89094C44Da98b954EedeAC495271d0F',
//     args: [
//       '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
//       '0x00De4B13153673BCAE2616b67bf822500d325Fc3',
//       { BigNumber: "250000000000000000" },
//       amount: { BigNumber: "250000000000000000" },
//       from: '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
//       to: '0x00De4B13153673BCAE2616b67bf822500d325Fc3'
//     ],
//     blockHash: '0x8462eb2fbcef5aa4861266f59ad5f47b9aa6525d767d713920fdbdfb6b0c0b78',
//     blockNumber: 9843476,
//     data: '0x00000000000000000000000000000000000000000000000003782dace9d90000',
//     decode: [Function],
//     event: 'Transfer',
//     eventSignature: 'Transfer(address,address,uint256)',
//     getBlock: [Function],
//     getTransaction: [Function],
//     getTransactionReceipt: [Function],
//     logIndex: 70,
//     removeListener: [Function],
//     removed: false,
//     topics: [
//       '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
//       '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72',
//       '0x00000000000000000000000000de4b13153673bcae2616b67bf822500d325fc3'
//     ],
//     transactionHash: '0x1be23554545030e1ce47391a41098a46ff426382ed740db62d63d7676ff6fcf1',
//     transactionIndex: 81
//   }
// ]

//
// The following have had the results omitted due to the
// number of entries; but they provide some useful examples
//

// List all transfers sent in the last 10,000 blocks
await daiContract.queryFilter(filterFrom, -10000)

// List all transfers ever sent to me
await daiContract.queryFilter(filterTo)
```

## Signing Messages
```javascript
// To sign a simple string, which are used for
// logging into a service, such as CryptoKitties,
// pass the string in.
signature = await signer.signMessage("Hello World");
// '0x5a77beb84677b221d7110b08605a2658dd6c1e88a2ba9293436e587dbf6479d4798d0ca34ba2113bdb51ad97cd831975ccaccaf5f6fbd5d566fe662f11e2ca411b'

//
// A common case is also signing a hash, which is 32
// bytes. It is important to note, that to sign binary
// data it MUST be an Array (or TypedArray)
//

// This string is 66 characters long
message = "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"

// This array representation is 32 bytes long
messageBytes = ethers.utils.arrayify(message);
// Uint8Array [ 221, 242, 82, 173, 27, 226, 200, 155, 105, 194, 176, 104, 252, 55, 141, 170, 149, 43, 167, 241, 99, 196, 161, 22, 40, 245, 90, 77, 245, 35, 179, 239 ]

// To sign a hash, you most often want to sign the bytes
signature = await signer.signMessage(messageBytes)
// '0xe099cce5e80dec1d8464d00c4156855d1c14cc4f83473deee7ab8e60be770f4b5ea04e90e7b7102ac5b493f7822b0ad10dc26bfda0761530a58e5f461f90b2fd1b'
```