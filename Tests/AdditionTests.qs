namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation TestAddition() : Unit {
        Message("Testing Addition");
        TestIncrement();
        TestIncrementConstant();
    }

    operation TestIncrement() : Unit {
        Message("Testing Increment");

        let maxValue = 7;
        use qubits = Qubit[4] {
            for i in 1 .. maxValue {
                for j in 0 .. i - 1 {
                    for k in 0 .. 5 {
                        SetValue(qubits, i);
                        IncrementConstant(qubits, j);

                        let result = AsInt(Measure(qubits));
                        Message($"Result of {i} + {j}: {result}");
                        ResetAll(qubits);
                    }
                }
            }
        }
    }

    operation TestIncrementConstant() : Unit {
        Message("Testing Increment Constant");

        let maxValue = 7;
        use (left, right) = (Qubit[4], Qubit[4]) {
            for i in 1 .. maxValue {
                for j in 0 .. i - 1 {
                    for k in 0 .. 5 {
                        SetValue(left, i);
                        SetValue(right, j);

                        Increment(left, right);

                        let result = AsInt(Measure(left));
                        Message($"Result of {i} + {j}: {result}");
                        ResetAll(left);
                    }
                }
            }
        }
    }
}