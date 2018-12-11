class KeysController < ApplicationController

    def public_key
        render :json => $rsa_keys.public_key
    end
    

end
