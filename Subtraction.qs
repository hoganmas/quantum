namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Decrement(left : Qubit[], right : Qubit[]) : Unit {
        use (carry, newCarry, one, sum) = (Qubit(), Qubit(), Qubit(), Qubit()) {
            X(carry);

            for i in 0 .. Length(right) - 1 {
                X(right[i]);
                FullAdder(left[i], right[i], carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i]);
                X(right[i]);
            }

            for i in Length(right) .. Length(left) - 1 {
                X(one);
                FullAdder(left[i], one, carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i]);
                Reset(one);
            }
            
            Reset(carry);
            Reset(newCarry);
            Reset(sum);
        }
    }

    operation DecrementConstant(left : Qubit[], right : Int) : Unit {
        let (aux, logAux) = GetAuxiliarModulus(right);

        use (carry, newCarry, rightBit, sum) = (Qubit(), Qubit(), Qubit(), Qubit()) {
            X(carry);

            for i in 0 .. logAux - 1 {
                GetBit(right, i, rightBit);
                X(rightBit);
                FullAdder(left[i], rightBit, carry, sum, newCarry);

                SWAP(carry, newCarry);
                SWAP(sum, left[i]);

                Reset(rightBit);
            }

            for i in logAux .. Length(left) - 1 {
                X(rightBit);
                FullAdder(left[i], rightBit, carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i]);
                Reset(rightBit);
            }

            Reset(carry);
            Reset(newCarry);
            Reset(sum);
        }        
    }

    operation ConditionalDecrementConstant(left : Qubit[], right : Int) : Unit {
        let (aux, logAux) = GetAuxiliarModulus(right);

        use (carry, newCarry, rightBit, lessThan, temp, sum) = (Qubit(), Qubit(), Qubit(), Qubit(), Qubit(), Qubit()) {
            ConstantLessThan(right, left, lessThan);

            X(carry);

            for i in 0 .. logAux - 1 {
                GetBit(right, i, rightBit);
                X(rightBit);
                CCNOT(rightBit, lessThan, temp);

                FullAdder(left[i], temp, carry, sum, newCarry);

                SWAP(carry, newCarry);
                SWAP(sum, left[i]);

                Reset(rightBit);
            }

            for i in logAux .. Length(left) - 1 {
                X(rightBit);
                CCNOT(rightBit, lessThan, temp);

                FullAdder(left[i], temp, carry, sum, newCarry);
                SWAP(carry, newCarry);
                SWAP(sum, left[i]);
                Reset(rightBit);
            }

            Reset(carry);
            Reset(newCarry);
            Reset(sum);
        }        
    }
}