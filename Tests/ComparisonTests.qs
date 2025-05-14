namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;

    operation TestComparison() : Unit {
        Message("Testing Comparison");
        TestLessThan();
    }

    operation TestLessThan() : Unit {
        Message("Testing Less Than");

        let maxValue = 15;
        use (left, right, result) = (Qubit[4], Qubit[4], Qubit()) {
            for i in 0 .. maxValue {
                for j in 0 .. maxValue {
                    SetValue(left, i);
                    SetValue(right, j);

                    LessThan(left, right, result);

                    let resultAsBool = ResultAsBool(M(result));
                    Fact(resultAsBool == (i < j), $"Result of {i} < {j}: {resultAsBool} (Actual) vs {i < j} (Expected)");
                    
                    ResetAll(left);
                    ResetAll(right);
                    Reset(result);
                }
            }
        }
    }
}
