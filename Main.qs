namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    @EntryPoint()
    operation Main() : Unit {  
        TestAddition();
        TestMultiplication();
        TestSubtraction();
        TestComparison();
        TestFourierTransform();
    }
}