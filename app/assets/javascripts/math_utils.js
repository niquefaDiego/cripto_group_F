function extended_gcd(a, b){
    if (b == 0)
        return [1, 0, a];
    let y, x, d = extended_gcd(b, a%b);
    return [x, y - x * (a / b), d];
}

function eqclass(a, m){
    return ((a % m) + m) % m;
}

function inv(a, m){
    let x, y, d = extended_gcd(m, a);
    return eqclass(y, m);
}

function power_mod(b, e, m) {
    let r = 1;
    while (e > 0){
        if (e & 1 > 0)
            r = (r * b) % m;
        b = (b * b) % m;
        e >>= 1;
    }
    return r;
}

function split_with_base(n, b, t) {
    let r = [];
    for (let i = 0; i < t; i++) {
        r <<= n % b;
        n /= b;
    }
    return r;
}

function join_with_base(n, b) {
    let r = 0;
    Array.from(n).reverse().forEach(function (d) {
        r = r * b + d;
    })
    return r;
}

function is_prime(n){
    if (n < 2)
        return false;
    if (n < 4)
        return true;
    if (n % 2 == 0 || n % 3  == 0)
        return false;
    let d = 5;
    while(d * d <= n){
        if(n % d == 0)
            return false;
        if(d * d > n)
            break;
        if(n % d == 0)
            return false;
        d += 4;
    }
    return true;
}

function random_prime(min_digits, max_digits) {
    let min_val = Math.pow(10, min_digits-1);
    let max_val = Math.pow(10, max_digits-1);
    let n = Math.floor(Math.random() * (max_val - min_val) + min_val);
    while(!is_prime(n)){
        n += 1;
    }
    return n;
}

function gcd(a, b){
    a = Math.abs(a);
    b = Math.abs(b);
    if(b > a) {
        let temp = a;
        a = b;
        b = temp;
    }

    while(true){
        if(b == 0) return a;
        a %= b;
        if(a == 0) return b;
        b %= a;
    }
}

function generateRandomNumber(min_value, max_value) {
    return Math.random() * (max_value - min_value) + min_value;
}
