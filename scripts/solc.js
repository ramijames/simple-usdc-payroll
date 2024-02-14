const solc = require("solc");
const fs = require("fs");

// Read the Solidity source code
const contractCode = fs.readFileSync("contracts/Payroll.sol", "utf8");

// Compile the Solidity contract
// const compiledContract = solc.compile(contractCode, 1);
// const contractABI = JSON.parse(
//   compiledContract.contracts[":Payroll"].interface
// );
// const contractBytecode = compiledContract.contracts[":Payroll"].bytecode;

// console.log("ABI:", contractABI);
// console.log("Bytecode:", contractBytecode);

console.log(contractCode);
