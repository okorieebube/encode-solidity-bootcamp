// "test:deploy_proxy": "npx hardhat test --network hardhat test/05_PROXIES/test.js",
const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("DogCoin", function () {
  before(async () => {
    DogCoin = await ethers.getContractFactory("DogCoin");
    DogCoinV2 = await ethers.getContractFactory("DogCoinV2");

  })
  it("deploys", async function () {
    DogCoin = await upgrades.deployProxy(DogCoin, { kind: "uups" });
  });
  it("upgrades", async function () {
    DogCoinV2 = await upgrades.upgradeProxy(DogCoin, DogCoinV2);
  });
  it("adds new variable - version", async function () {
    await DogCoinV2.version();
    expect(await DogCoinV2.version()).to.equal("v2");
  });
});
