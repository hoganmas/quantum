namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation TestAddition() : Unit {
        Message("Testing Addition");
        TestIncrement();
        TestIncrementConstant();
    }

    operation TestIncrement() : Unit {
        Message("Testing Increment");

        let maxValue = 7;
        use (left, right) = (Qubit[4], Qubit[4]) {
            for i in 1 .. maxValue {
                for j in 0 .. i - 1 {
                    SetValue(left, i);
                    SetValue(right, j);

                    Increment(left, right);

                    let result = ResultArrayAsInt(MeasureEachZ(left));
                    Fact(result == (i + j), $"Result of {i} + {j}: {result} (Actual) vs {i + j} (Expected)");

                    ResetAll(left);
                    ResetAll(right);
                }
            }
        }
    }

    operation TestIncrementConstant() : Unit {
        Message("Testing Increment Constant");

        let maxValue = 7;
        use qubits = Qubit[4] {
            for i in 1 .. maxValue {
                for j in 0 .. i - 1 {
                    SetValue(qubits, i);
                    IncrementConstant(qubits, j);

                    let result = ResultArrayAsInt(MeasureEachZ(qubits));
                    Fact(result == (i + j), $"Result of {i} + {j}: {result} (Actual) vs {i + j} (Expected)");

                    ResetAll(qubits);
                }
            }
        }
    }
}