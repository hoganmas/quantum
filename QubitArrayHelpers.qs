namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

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

    operation FourierTransform(qubits : Qubit[]): Unit {
        for i in 0 .. Length(qubits) - 1 {
            H(qubits[i]);

            for j in i + 1 .. Length(qubits) - 1 {
                let k = j - i;
                Controlled R1([qubits[j]], (2.0 * PI() / IntAsDouble(2^k), qubits[i]));
            }
        }

        for i in 0 .. (Length(qubits) - 1) / 2 {
            SWAP(qubits[i], qubits[Length(qubits) - 1 - i]);
        }
    }
}