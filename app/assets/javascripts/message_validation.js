function validate_message(message, encrypted_hash){
    const BLOCK_SIZE = 6;

    let url = window.location.protocol + "//" + window.location.host + "/public_key";

    return fetch(url)
        .then(response => response.json())
        .then(function (pk) {
           if(pk.length == 2 && !isNaN(encrypted_hash)){
               let e = pk[0];
               let n = pk[1];

               let hash = parseInt(md5(message), 16);
               console.log("hash: ", hash);

               encrypted_hash = parseInt(encrypted_hash, 10);
               let sigma = rsa(encrypted_hash, pk);
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
