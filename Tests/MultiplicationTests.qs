namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation TestMultiplication() : Unit {
        Message("Testing Multiplication");
        TestMultiply();
        TestMultiplyConstant();
    }

    operation TestMultiply() : Unit {
        Message("Testing Multiply");

        let maxValue = 7;
        use (left, right, results) = (Qubit[4], Qubit[4], Qubit[8]) {
            for i in 1 .. maxValue {
                for j in 0 .. i - 1 {
                    SetValue(left, i);
                    SetValue(right, j);

                    Multiply(left, right, results);

                    let result = ResultArrayAsInt(MeasureEachZ(results));
                    Fact(result == (i * j), $"Result of {i} * {j}: {result} (Actual) vs {i * j} (Expected)");

                    ResetAll(left);
                    ResetAll(right);
                    ResetAll(results);
                }
            }
        }
    }

    operation TestMultiplyConstant() : Unit {
        Message("Testing Multiply Constant");

        let maxValue = 7;
        use (qubits, results) = (Qubit[4], Qubit[8]) {
            for i in 1 .. maxValue {
                for j in 0 .. i - 1 {
                    SetValue(qubits, i);
                    MultiplyConstant(qubits, j, results);

                    let result = ResultArrayAsInt(MeasureEachZ(results));
                    Fact(result == (i * j), $"Result of {i} * {j}: {result} (Actual) vs {i * j} (Expected)");

                    ResetAll(qubits);
                    ResetAll(results);
                }
            }
        }
    }
}