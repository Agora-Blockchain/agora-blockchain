import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const GeneralResultCalculatorModule = buildModule("GeneralResultCalculatorModule", (m) => {
    const generalResultCalculator = m.contract("GeneralResultCalculator", [], {});
    return { generalResultCalculator };
});

export default GeneralResultCalculatorModule;