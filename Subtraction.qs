namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

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
}