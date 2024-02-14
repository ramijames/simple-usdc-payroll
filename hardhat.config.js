require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    goerli: {
      url: "wss://ethereum-goerli.publicnode.com",
      accounts: [
        "7c5637ec781458caaab0e6542569b6ac092b9ec2051d8940863be714d1abc8f0",
      ],
    },
  },
};
