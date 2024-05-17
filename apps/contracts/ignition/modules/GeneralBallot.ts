import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const GeneralBallotModule = buildModule("GeneralBallotModule", (m) => {
    const generalBallot = m.contract("GeneralBallot", [], {});
    return { generalBallot };
});

export default GeneralBallotModule;