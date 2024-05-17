import {
    loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";


describe("ElectionFactory",function (){
    async function deployElectionFactoryFixture(){
        const ElectionFactory = await hre.ethers.getContractFactory("ElectionFactory");
        const electionFactory = await ElectionFactory.deploy();

        const Ballot = await hre.ethers.getContractFactory("GeneralBallot");
        const ballot = await Ballot.deploy();

        const ResultCalculator = await hre.ethers.getContractFactory("GeneralResultCalculator");
        const resultCalculator = await ResultCalculator.deploy();

        return {electionFactory,ballot,resultCalculator};
    }

    describe("Deployment",function(){
        it("Should deploy the ElectionFactory contract", async function(){
            const {electionFactory} = await loadFixture(deployElectionFactoryFixture);
            expect(electionFactory.target).to.be.properAddress;
        });
        it("Should have the correct owner", async function(){
            const [owner] = await hre.ethers.getSigners();
            const {electionFactory} = await loadFixture(deployElectionFactoryFixture);
            expect(await electionFactory.owner()).to.equal(owner);
        });
        it("Should have set the election implementation contract correctly", async function(){
            const {electionFactory} = await loadFixture(deployElectionFactoryFixture);
            const electionImplementation = await electionFactory.getElectionImplementation();
            console.log("Election Implementation: ",electionImplementation);
            expect(electionImplementation).to.be.properAddress;
        });
    });

    describe("Add new ballot",async function (){
        it("Should add a new ballot", async function(){
            const {electionFactory,ballot} = await loadFixture(deployElectionFactoryFixture);
            
            const ballotAddr = ballot.target;
        
            const [owner] = await hre.ethers.getSigners();
            const tx = await electionFactory.addBallotType(1,ballotAddr);
            await tx.wait();
            const ballotType = await electionFactory.ballotIdToType(1);
            expect(ballotType).to.equal(ballotAddr);
        });
    })

    describe("Add new result calculator",async function (){
        it("Should add a new result calculator", async function(){
            const {electionFactory,resultCalculator} = await loadFixture(deployElectionFactoryFixture);
            
            const resultCalculatorAddr = resultCalculator.target;
        
            const [owner] = await hre.ethers.getSigners();
            const tx = await electionFactory.addResultCalculatorType(1,resultCalculatorAddr);
            await tx.wait();
            const resultCalculatorType = await electionFactory.resultCalculatorIdToType(1);
            expect(resultCalculatorType).to.equal(resultCalculatorAddr);
        });
    });

})