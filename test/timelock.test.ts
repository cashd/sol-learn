import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { expect } from 'chai';
import { ethers } from 'hardhat';
import { TimeLock } from '../typechain';

describe('Timelock', () => {
    let owner: SignerWithAddress;
    let timelock: TimeLock;

    beforeEach(async () => {
        [owner] = await ethers.getSigners();

        const timelockFactory = await ethers.getContractFactory('TimeLock');
        timelock = await timelockFactory.connect(owner).deploy();
        await timelock.deployed();
    });

    it('owner is msg.sender', async () => {
        expect(await timelock.owner()).eq(owner.address);
    });
});
