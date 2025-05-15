namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation TestMontgomery() : Unit {
        Message("Testing Montgomery");

        let space = GenerateMontgomerySpace(17);
        use qubits = Qubit[space::logAux] {
            SetValue(qubits, 13);
            MontgomeryTransform(qubits, space);
            MontgomeryMultiplyConstant(qubits, 7, qubits, space);
            MontgomeryReduce(qubits, space);

            let result = ResultArrayAsInt(MeasureEachZ(qubits));
            Fact(result == (13 * 7 % 17), $"Result of 13 * 7 % 17: {result} (Actual) vs {13 * 7 % 17} (Expected)");
            ResetAll(qubits);
        }
    }

}