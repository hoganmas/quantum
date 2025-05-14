namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation TestFourierTransform() : Unit {
        Message("Testing Fourier Transform");
        Message("Expecting uniform distribution...");

        let numSamples = 20;
        use qubits = Qubit[4] {
            for i in 0 .. numSamples - 1 {
                FourierTransform(qubits);
                let result = ResultArrayAsInt(MeasureEachZ(qubits));
                Message($"Result: {result}");
                ResetAll(qubits);
            }
        }
    }

}