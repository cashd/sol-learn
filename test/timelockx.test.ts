describe("TimelockX", () => {
    // let owner: SignerWithAddress;
    // let timelock: TimeLock;

    beforeEach(async () => {
        // [owner] = await ethers.getSigners();
        // const timelockFactory = await ethers.getContractFactory("TimeLock");
        // timelock = await timelockFactory.connect(owner).deploy();
        // await timelock.deployed();
    });

    it("owner is msg.sender", async () => {
        // expect(await timelock.owner()).eq(owner.address);
    });

    it("can queue and execute transaction", async () => {
        // using greeter contract for calldata
        // const greeterFactory = await ethers.getContractFactory("Greeter");
        // const greeterContract = await greeterFactory
        //     .connect(owner)
        //     .deploy("tester");
        // await greeterContract.deployed();
        // const calldata = greeterContract.interface.encodeFunctionData(
        //     "setGreeting",
        //     ["test2"]
        // );
        // const currentBlockNumber = await ethers.provider.blockNumber;
        // const currentBlock = await ethers.provider.getBlock(currentBlockNumber);
        // const timestamp = currentBlock.timestamp + 100;
        // await timelock.queue(
        //     greeterContract.address,
        //     0,
        //     "",
        //     calldata,
        //     timestamp
        // );
        // await network.provider.send("evm_setNextBlockTimestamp", [
        //     timestamp + 1,
        // ]);
        // await network.provider.send("evm_mine");
        // await timelock.execute(
        //     greeterContract.address,
        //     0,
        //     "",
        //     calldata,
        //     timestamp
        // );
        // expect(await greeterContract.greet()).eq("test2");
    });
});
