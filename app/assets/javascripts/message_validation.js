function validate_message(message, encrypted_hash){
    const BLOCK_SIZE = 6;

    let url = window.location.protocol + "//" + window.location.host + "/public_key";

    async function getPublicKey() {
        try{
            let res = await fetch(url);
            return res.json();
        }
        catch (e) {
            console.warn("Not possible to retrieve public key due to: ", e.toString());
            return null;
        }
    }

    (async function () {
        let ans = await getPublicKey();
        if(ans != null && ans.length == 2){
            console.log("Hash for message ", message, ": ", md5(message));

            let hash = md5(message);
            let n = ans[1];
            let arr_hash = split_with_base(message, n, BLOCK_SIZE);
            let enc_hash_pk_server_arr = rsa(arr_hash, ans);
            let enc_hash_pk_server = join_with_base(enc_hash_pk_server_arr, n);

            console.log("Validation: " , new String(enc_hash_pk_server).trim().valueOf() == new String(encrypted_hash).trim().valueOf());

            // TODO: fix return from async function
            return Boolean(new String(enc_hash_pk_server).trim().valueOf() == new String(encrypted_hash).trim().valueOf());
        }
        return false;
    })();
}
