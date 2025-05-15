namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Multiply(left : Qubit[], right : Qubit[], results : Qubit[]) : Unit {  
        use operand = Qubit[Length(right)] {
            for i in 0 .. Length(left) - 1 {                
                // Generate operand1
                for j in 0 .. Length(right) - 1 {
                    Reset(operand[j]);
                    CCNOT(left[i], right[j], operand[j]);
                }

                Increment(
                    results[i .. Min(Length(results) - 1, i + Length(operand))], 
                    operand[0 .. Min(Length(results) - i, Length(operand)) - 1]
                );
            }

            ResetAll(operand);
        }
    }

    operation MultiplyConstant(left : Qubit[], right : Int, results : Qubit[]) : Unit {  
        let (aux, logAux) = GetAuxiliarModulus(right);

        for i in 0 .. Length(left) - 1 {
            use (carry, newCarry, temp, rightBit, sum) = (Qubit(), Qubit(), Qubit(), Qubit(), Qubit()) {
                for j in 0 .. Min(logAux, Length(results) - i) - 1 {
                    GetBit(right, j, temp);
                    CCNOT(left[i], temp, rightBit);

                    FullAdder(results[i + j], rightBit, carry, sum, newCarry);
                    SWAP(carry, newCarry);
                    SWAP(sum, results[i + j]);

                    Reset(rightBit);
                    Reset(temp);
                }

                for j in logAux .. Length(results) - i - 1 {
                    HalfAdder(results[i + j], carry, sum, newCarry);
                    SWAP(carry, newCarry);
                    SWAP(sum, results[i + j]);
                }
                
                Reset(carry);
                Reset(newCarry);
                Reset(sum);
            }
        }
    }
}