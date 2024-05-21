import {
    loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";


describe("ElectionFactory",function (){
    async function deployElectionFactoryFixture(){
        const ElectionFactory = await hre.ethers.getContractFactory("ElectionFactory");
        const electionFactory = await ElectionFactory.deploy();
        return {electionFactory};
    }

    describe("Deployment",function(){
        it("Should deploy the ElectionFactory contract", async function(){
            const {electionFactory} = await loadFixture(deployElectionFactoryFixture);
            expect(electionFactory.target).to.be.properAddress;
        });
    });
})