namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation SampleDistribution(qubits : Qubit[], count : Int): Int[] {
        mutable results = new Int[count];
        use sample = Qubit[Length(qubits)] {
            for i in 0 .. count - 1 {
                for j in 0 .. Length(qubits) - 1 {
                    CNOT(qubits[j], sample[j]);
                }

                let result = Measure(sample);
                set results w/= i <- AsInt(result);

                ResetAll(sample);
            } 
        }
        return results;
    }

    operation TestFourierTransform() : Unit {
        Message("Testing Fourier Transform");
        Message("Expecting uniform distribution...");

        let numSamples = 20;
        use qubits = Qubit[4] {
            for i in 0 .. numSamples - 1 {
                FourierTransform(qubits);
                let result = AsInt(Measure(qubits));
                Message($"Result: {result}");
                ResetAll(qubits);
            }
        }
    }

}