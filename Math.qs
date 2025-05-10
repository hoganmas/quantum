namespace Quantum {
    open Microsoft.Quantum.Convert;

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
}