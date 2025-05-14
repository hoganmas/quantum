namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
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

    operation HalfAdder(q1 : Qubit, q2 : Qubit, sum: Qubit, carry : Qubit) : Unit {
        Reset(sum);
        Reset(carry);

        // sum := q1 XOR q2 XOR q3 
        CNOT(q1, sum);
        CNOT(q2, sum);

        // carry := (q1 AND q2) XOR (q1 AND q3) XOR (q2 AND q3)
        CCNOT(q1, q2, carry);
    }

    operation Mux(q1 : Qubit, q2 : Qubit, selector : Qubit, control : Qubit) : Unit {
        // control := q1 AND selector
        CCNOT(q1, selector, control);
        X(selector);

        // control := (q1 AND selector) XOR (q2 AND NOT selector)
        CCNOT(q2, selector, control);
        X(selector);
    }
}