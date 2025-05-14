namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation FixedLengthAdd(left : Qubit[], right : Qubit[], results : Qubit[]) : Unit {
        Fact(Length(left) == Length(right), "Left and right operand arrays must be the same length");
        Fact(Length(results) == Length(left), "Results array must be the same length as left and right operand arrays");

        use (carry, newCarry) = (Qubit(), Qubit()) {
            for i in 0 .. Length(left) - 1 {
                FullAdder(left[i], right[i], carry, results[i], newCarry);
                SWAP(carry, newCarry);
            }
            Reset(carry);
            Reset(newCarry);
        }
    }

    operation Increment(left : Qubit[], right : Qubit[]) : Unit {
        use (carry, newCarry, sum) = (Qubit(), Qubit(), Qubit()) {
            for i in 0 .. Length(right) - 1 {
                FullAdder(left[i], right[i], carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i]);
            }

            for i in Length(right) .. Length(left) - 1 {
                HalfAdder(left[i], carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i]);
            }
            
            Reset(carry);
            Reset(newCarry);
            Reset(sum);
        }
    }

    operation IncrementConstant(left : Qubit[], right : Int) : Unit {
        let (aux, logAux) = GetAuxiliarModulus(right);

        use (carry, newCarry, rightBit, sum) = (Qubit(), Qubit(), Qubit(), Qubit()) {
            for i in 0 .. logAux - 1 {
                GetBit(right, i, rightBit);
                FullAdder(left[i], rightBit, carry, sum, newCarry);

                SWAP(carry, newCarry);
                SWAP(sum, left[i]);

                Reset(rightBit);
            }

            for i in logAux .. Length(left) - 1 {
                HalfAdder(left[i], carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i]);
            }


            Reset(carry);
            Reset(newCarry);
            Reset(sum);
        }        
    }

    operation IncrementWithOffset(left : Qubit[], right : Qubit[], leftIndex : Int) : Unit {
        use (carry, newCarry, sum) = (Qubit(), Qubit(), Qubit()) {
            for i in 0 .. Min(Length(right), Length(left) - leftIndex) - 1 {
                FullAdder(left[i + leftIndex], right[i], carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i + leftIndex]);
            }

            for i in Min(Length(right), Length(left) - leftIndex) .. Length(left) - leftIndex - 1 {
                HalfAdder(left[i + leftIndex], carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i + leftIndex]);
            }
            
            Reset(carry);
            Reset(newCarry);
            Reset(sum);
        }
    }
}