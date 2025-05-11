namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    @EntryPoint()
    operation Main() : Result[] {  
        let length = 4;
        use (a, b, c) = (Qubit[length], Qubit[length], Qubit[2 * length]) {
            
            // Both a and b will be in a superposition of 0..7
            SetValue(a, 5);
            SetValue(b, 7);

            Message("Starting multiplication");
            DoubleLengthMultiply(a, b, c);

            let results = Measure(c);
            let result = AsInt(results);
            Message($"Result: {result}");

            ResetAll(a);
            ResetAll(b);
            ResetAll(c);

            return results;
        }
    }
}