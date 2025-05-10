namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Multiply(left : Qubit[], right : Qubit[], results : Qubit[]) : Unit {        
        use (operand1, operand2) = (Qubit[Length(left)], Qubit[Length(left)]) {
            for i in 0 .. Length(left) - 1 {
                // Swap operand2 with results
                if (i > 0) {
                    for j in i .. Length(left) - 1 {
                        SWAP(operand2[j], results[j]);
                        Reset(results[j]);
                    }
                }

                // Generate operand1
                for j in 0 .. Length(left) - 1 - i {
                    Reset(operand1[i + j]);
                    CCNOT(left[i], right[j], operand1[i + j]);
                }

                AddSlice(operand1, operand2, results, i);
            }

            ResetAll(operand1);
            ResetAll(operand2);
        }
    }
}