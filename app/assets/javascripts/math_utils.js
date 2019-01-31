function extended_gcd(a, b){
    if (b == 0)
        return [1, 0, a];
    var y, x, d = extended_gcd(b, a%b);
    return [x, y - x * (a / b), d];
}

function eqclass(a, m){
    return ((a % m) + m) % m;
}

function inv(a, m){
    var x, y, d = extended_gcd(m, a);
    return eqclass(y, m);
}

function power_mod(b, e, m) {
    b = BigInt(b);
    e = BigInt(e);
    m = BigInt(m);

    var z = 1n;

    var bin_e = (+e.toString()).toString(2);
    for(var digit of bin_e){
        if(digit == '0'){
            z = (z ** 2n) % m;
        }else if(digit == '1'){
            z = ((z ** 2n) * b) % m;
        }
    }
    return z;
}

function split_with_base(n, b, t) {
    var r = [];
    for (var i = 0; i < t; i++) {
        r <<= n % b;
        n /= b;
    }
    return r;
}

function join_with_base(n, b) {
    var r = 0;
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
    var d = 5;
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
    var min_val = Math.pow(10, min_digits-1);
    var max_val = Math.pow(10, max_digits-1);
    var n = Math.floor(Math.random() * (max_val - min_val) + min_val);
    while(!is_prime(n)){
        n += 1;
    }
    return n;
}

function gcd(a, b){
    a = Math.abs(a);
    b = Math.abs(b);
    if(b > a) {
        var temp = a;
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
