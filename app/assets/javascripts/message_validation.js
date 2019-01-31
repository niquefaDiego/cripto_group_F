function validate_message(message, encrypted_hash){
    const BLOCK_SIZE = 6;

    var url = window.location.protocol + "//" + window.location.host + "/public_key";

    return fetch(url)
        .then(response => response.json())
        .then(function (pk) {
           if(pk.length == 2 && !isNaN(encrypted_hash)){
               var e = pk[0];
               var n = pk[1];

               var str_hash = "0x" + md5(message);
               var hash = BigInt(str_hash) % BigInt(n);
               console.log("hash: ", hash);

               encrypted_hash = BigInt(encrypted_hash);
               var sigma = rsa(encrypted_hash, pk);
               console.log("sigma: ", sigma);

               return sigma == hash;
           }
            console.warn("Message validation: Invalid parameters were received");
           return false;
        })
        .catch(function (error) {
            console.log("Error while retrieving public key from server: " + error);
        });
}
