function validate_message(message, encrypted_hash){
    const BLOCK_SIZE = 6;

    let url = window.location.protocol + "//" + window.location.host + "/public_key";

    return fetch(url)
        .then(response => response.json())
        .then(function (pk) {
           if(pk.length == 2){
               let e = pk[0];
               let n = pk[1];

               let hash = md5(message);
               let arr_hash = split_with_base(hash, n, BLOCK_SIZE);
               let enc_hash_pk_server_arr = rsa(arr_hash, pk);
               let enc_hash_pk_server = join_with_base(enc_hash_pk_server_arr, n);

               return enc_hash_pk_server == encrypted_hash;
           }
           return false;
        })
        .catch(function (error) {
            console.log("Error while retrieving public key from server: " + error);
        });
}
