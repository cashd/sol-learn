import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { Contract } from "ethers";
import { ethers } from "hardhat";
import { Logic, Proxy } from "../typechain";

describe("Proxy contract", async () => {
  let owner: SignerWithAddress;
  let proxy: Proxy;
  let logic: Logic;

  beforeEach(async () => {
    [owner] = await ethers.getSigners();

    const logicFactory = await ethers.getContractFactory("Logic");
    logic = await logicFactory.deploy();
    await logic.deployed();

    const proxyFactory = await ethers.getContractFactory("Proxy");
    proxy = await proxyFactory.deploy();
    await proxy.deployed();

    await proxy.setImpl(logic.address);

    const abi = ["function initialize() public"];
    const proxied = new Contract(proxy.address, abi, owner);
    await proxied.initialize();
  });

  it("points to an implementation contract", async () => {
    expect(await proxy.getImpl()).to.eq(logic.address);
  });

  it("number in logic contract is correct", async () => {
    const abi = [
      "function setNumber(uint256 _number) public",
      "function getNumber() public view returns (uint256)",
    ];
    const proxied = new ethers.Contract(proxy.address, abi, owner);

    expect(await proxied.getNumber()).to.eq("0x42");
  });
});
