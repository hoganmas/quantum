namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation FixedLengthMultiply(left : Qubit[], right : Qubit[], results : Qubit[]) : Unit {  
        Fact(Length(left) == Length(right), "Left and right operand arrays must be the same length");
        Fact(Length(results) == Length(left), "Results array must be the same length as left and right operand arrays");

        use operand = Qubit[Length(right)] {
            for i in 0 .. Length(left) - 1 {
                Message($"Multiplication Iteration {i}");
                
                // Generate operand1
                for j in 0 .. Length(right) - 1 {
                    Reset(operand[j]);
                    CCNOT(left[i], right[j], operand[j]);
                }

                IncrementWithOffset(results, operand, i);
            }

            ResetAll(operand);
        }
    }

    operation DoubleLengthMultiply(left : Qubit[], right : Qubit[], results : Qubit[]) : Unit {  
        Fact(Length(left) == Length(right), "Left and right operand arrays must be the same length");
        Fact(Length(results) == Length(left) * 2, "Results array must be double the length of left and right operand arrays");

        use operand = Qubit[Length(right)] {
            for i in 0 .. Length(left) - 1 {
                Message($"Multiplication Iteration {i}");
                
                // Generate operand1
                for j in 0 .. Length(right) - 1 {
                    Reset(operand[j]);
                    CCNOT(left[i], right[j], operand[j]);
                }

                IncrementWithOffset(results, operand, i);
            }

            ResetAll(operand);
        }
    }
}