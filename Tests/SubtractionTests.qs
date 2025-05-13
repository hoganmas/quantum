namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation TestSubtraction() : Unit {
        Message("Testing Subtraction");

        let maxValue = 15;
        use qubits = Qubit[4] {
            for i in 1 .. maxValue {
                for j in 0 .. i {
                    SetValue(qubits, i);
                    DecrementConstant(qubits, j);

                    let result = AsInt(Measure(qubits));
                    Message($"Result of {i} - {j}: {result}");
                    ResetAll(qubits);
                }
            }
        }
    }

}