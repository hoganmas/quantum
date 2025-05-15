namespace Quantum {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    newtype MontgomerySpace = (
        modulus : Int,
        aux : Int,
        logAux : Int,
        inverseModulus : Int,
        negInverseModulus : Int,
        inverseAux : Int
    );

    function GenerateMontgomerySpace(modulus : Int) : MontgomerySpace {
        let (aux, logAux) = GetAuxiliarModulus(modulus);
        let (gcd, inverseAux, inverseModulus) = ExtendedEuclidean(aux, modulus);
        Fact(gcd == 1, "Modulus and auxiliar must be coprime");

        let negInverseModulus = inverseModulus > 0 ? aux - inverseModulus | -inverseModulus;

        return MontgomerySpace(
            modulus,
            aux,
            logAux,
            inverseModulus,
            negInverseModulus,
            inverseAux
        );
    }

    function GetAuxiliarModulus(modulus : Int) : (Int, Int) {
        mutable result = 1;
        mutable logResult = 0;
        while (result <= modulus) {
            set result = result <<< 1;
            set logResult = logResult + 1;
        }
        return (result, logResult);
    }

    function ExtendedEuclidean(a : Int, b : Int) : (Int, Int, Int) {
        mutable (oldR, r) = (a, b);
        mutable (oldS, s) = (1, 0);
        mutable (oldT, t) = (0, 1);

        while (r != 0) {
            let q = oldR / r;

            set (oldR, r) = (r, oldR - q * r);
            set (oldS, s) = (s, oldS - q * s);
            set (oldT, t) = (t, oldT - q * t);
        }

        return (oldR, oldS, oldT);
    }

    function GetInverseModulus(modulus : Int) : Int {
        let (aux, logAux) = GetAuxiliarModulus(modulus);
        let (gcd, x, y) = ExtendedEuclidean(aux, modulus);
        return aux - x;
    }

    operation Reduce(value : Qubit[], space : MontgomerySpace) : Unit {
        use q = Qubit[space::logAux] {
            MultiplyConstant(value[0 .. space::logAux - 1], space::negInverseModulus, q);

            use p = Qubit[2 * space::logAux] {
                MultiplyConstant(q, space::modulus, p);

                for i in 0 .. space::logAux - 1 {
                    SWAP(q[i], p[i + space::logAux]);
                }

                ResetAll(p);
            }

            for i in 0 .. space::logAux - 1 {
                Reset(value[i]);
                SWAP(value[i], value[i + space::logAux]);
            }

            Increment(value[0 .. space::logAux - 1], q);
            ConditionalDecrementConstant(value[0 ..space::logAux - 1], space::modulus);

            ResetAll(q);
        }
    }
}