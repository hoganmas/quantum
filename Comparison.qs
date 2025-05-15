namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation LessThan(left : Qubit[], right : Qubit[], result : Qubit) : Unit {
        use (notEquals, subResult) = (Qubit(), Qubit()) {
            for i in 0 .. Max(Length(left), Length(right)) - 1 {
                // notEquals := left[i] XOR right[i]
                if (i < Length(left)) {
                    CNOT(left[i], notEquals);
                }

                if (i < Length(right)) {
                    CNOT(right[i], notEquals);
                }

                // result := notEquals ? right[i] : result
                if (i < Length(right)) {
                    Mux(right[i], result, notEquals, subResult);
                }
                else {
                    X(notEquals);
                    CCNOT(notEquals, result, subResult);
                    X(notEquals);
                }

                SWAP(result, subResult);
                Reset(subResult);
                Reset(notEquals);
            }
        }
    }

    operation ConstantLessThan(left : Int, right : Qubit[], result : Qubit) : Unit {
        use (leftBit, notEquals, subResult) = (Qubit(), Qubit(), Qubit()) {
            for i in 0 .. Length(right) - 1 {
                // notEquals := left[i] XOR right[i]
                GetBit(left, i, leftBit);
                CNOT(leftBit, notEquals);
                Reset(leftBit);

                if (i < Length(right)) {
                    CNOT(right[i], notEquals);
                }

                // result := notEquals ? right[i] : result
                if (i < Length(right)) {
                    Mux(right[i], result, notEquals, subResult);
                }
                else {
                    X(notEquals);
                    CCNOT(notEquals, result, subResult);
                    X(notEquals);
                }

                SWAP(result, subResult);
                Reset(subResult);
                Reset(notEquals);
            }
        }
    }
}