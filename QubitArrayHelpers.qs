namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Hadamard(qubits : Qubit[], length : Int): Unit {
        for i in 0 .. Min(Length(qubits), length) - 1 {
            H(qubits[i]);
        }
    }

    operation SetValue(qubits : Qubit[], value : Int): Unit {
        for i in 0 .. Length(qubits) - 1 {
            if ((1 &&& (value >>> i)) == 1) {
                X(qubits[i]);
            }
        }
    }

    operation Measure(qubits : Qubit[]) : Result[] {
        mutable results = new Result[Length(qubits)];
        for i in 0 .. Length(qubits) - 1 {
            set results w/= i <- M(qubits[i]);
            Reset(qubits[i]);
        }
        return results;
    }
}