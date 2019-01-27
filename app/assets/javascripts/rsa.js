class RSAKeys{
    constructor(){
        e, n, d;
    }

    get public_key(){
        return [e, n];
    }

    get private_key(){
        return [d, n];
    }

    initialize(min_digits){
        let p = random_prime(min_digits, min_digits+1);
        let q = random_prime(min_digits, min_digits+1);

        while (p == q){
            q = random_prime(min_digits, min_digits+1);
        }

        this.n = p * q;
        let phi = (p-1) * (q-1);

        this.e = 0;
        while(gcd(this.e, phi) != 1){
            this.e = generateRandomNumber(2, phi-1);
        }

        this.d = inv(this.e, phi);
    }
}

function rsa(m, key) {
    m = BigInt(m);
    let d = BigInt(key[0]);
    let n = BigInt(key[1]);

    let c = power_mod(m, d, n);
    return c;
}