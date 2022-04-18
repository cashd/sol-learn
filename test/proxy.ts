import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
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
  });

  it("test1", async function () {
    return true;
  });
});
