namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Add(left : Qubit[], right : Qubit[], results : Qubit[]) : Unit {
        ResetAll(results);
        use (carry, newCarry) = (Qubit(), Qubit()) {
            for i in 0 .. Length(left) - 1 {
                FullAdder(left[i], right[i], carry, results[i], newCarry);
                SWAP(carry, newCarry);
            }
            Reset(carry);
            Reset(newCarry);
        }
    }

    operation FullAdder(q1 : Qubit, q2 : Qubit, q3 : Qubit, sum: Qubit, carry : Qubit) : Unit {
        Reset(sum);
        Reset(carry);

        // sum := q1 XOR q2 XOR q3 
        CNOT(q1, sum);
        CNOT(q2, sum);
        CNOT(q3, sum);

        // carry := (q1 AND q2) XOR (q1 AND q3) XOR (q2 AND q3)
        CCNOT(q1, q2, carry);
        CCNOT(q1, q3, carry);
        CCNOT(q2, q3, carry);
    }
}