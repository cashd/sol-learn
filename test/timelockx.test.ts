import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers, network } from "hardhat";
import { TimeLockX } from "../typechain";

describe("TimelockX", () => {
    let owner: SignerWithAddress;
    let timelock: TimeLockX;

    beforeEach(async () => {
        [owner] = await ethers.getSigners();
        const timelockXFactory = await ethers.getContractFactory("TimeLockX");
        timelock = await timelockXFactory.connect(owner).deploy(100);
        await timelock.deployed();
    });

    it("owner is msg.sender", async () => {
        expect(await timelock.owner()).eq(owner.address);
    });

    it("can queue and execute transaction", async () => {
        // using greeter contract for calldata
        const greeterFactory = await ethers.getContractFactory("Greeter");
        const greeterContract = await greeterFactory
            .connect(owner)
            .deploy("tester");
        await greeterContract.deployed();

        const calldata = greeterContract.interface.encodeFunctionData(
            "setGreeting",
            ["test2"]
        );

        const callHash = await timelock.encodeCall(
            [greeterContract.address],
            [calldata]
        );
        await timelock.registerCall(callHash);

        const currentBlockNumber = await ethers.provider.blockNumber;
        const currentBlock = await ethers.provider.getBlock(currentBlockNumber);
        const timestamp = currentBlock.timestamp;

        await network.provider.send("evm_setNextBlockTimestamp", [
            timestamp + 222,
        ]);
        await network.provider.send("evm_mine");
        await timelock.executeCall([greeterContract.address], [calldata]);
        expect(await greeterContract.greet()).eq("test2");
    });
});
