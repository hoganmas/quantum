namespace Quantum {
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    function Min(a : Int, b : Int) : Int {
        return a < b ? a | b;
    }

    function Max(a : Int, b : Int) : Int {
        return a > b ? a | b;
    }

    operation AsInt(results : Result[]) : Int {
        mutable result = 0;
        for i in 0 .. Length(results) - 1 {
            if ResultAsBool(results[i]) {
                set result += (1 <<< i);
            }
        }
        return result;
    }

    operation GetBit(value : Int, bitIndex : Int, qubit : Qubit) : Unit {
        if (((value >>> bitIndex) &&& 1) == 1) {
            X(qubit);
        }
    }
}