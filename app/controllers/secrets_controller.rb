class SecretsController < ApplicationController

  protect_from_forgery with: Exception

  before_action :set_secret, only: [:show, :edit, :update, :destroy]


  # GET /secrets
  # GET /secrets.json
  def index
    @algorithm_name = CriptoAlgorithms.names
    @secrets = Secret.all
  end

  # GET /secrets/1
  # GET /secrets/1.json
  def show
    # Redirects to secrets index when te user tries to access another user secret
    if @secret.user_id != current_user.id
      redirect_to secrets_path
    end
    @algorithm_name = CriptoAlgorithms.names
    @key = params[:key] #unsafe? :v
  end

  # GET /secrets/new
  def new
    @secret = Secret.new
  end


  def decipher
    # TODO page to decipher a message with ID or ciphertext
  end

  # GET /secrets/1/edit
  def edit
  end

  # POST /secrets
  # POST /secrets.json
  def create

    data = secret_params
    
    plaintext = data[:message]
    key = data[:key]
    errors = []

    
    errors.append([:message, "must consist of only ASCII characters"]) if !plaintext.ascii_only?
    errors.append([:key, "must consist of only ASCII characters"]) if !key.ascii_only?
    errors.append([:message, "can't be blank"]) if plaintext.blank?
    errors.append([:key, "can't be blank"]) if key.blank?

    algorithm = data[:algorithm].to_i

    if errors.empty?
      ciphertext = CriptoAlgorithms.encrypt(algorithm,plaintext,key)
      @secret = Secret.new({ciphertext: ciphertext, algorithm: algorithm, user_id: current_user.id})
    else
      @secret = Secret.new({ciphertext: "", algorithm: algorithm})
      for e in errors do @secret.errors.add(e[0], e[1]) end
    end 

    respond_to do |format|
      if errors.empty? && @secret.save
        format.html { redirect_to @secret, notice: 'El secreto se creó correctamente.' }
        format.json { render :show, status: :created, location: @secret }
      else
        format.html { render :new }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secrets/1
  # PATCH/PUT /secrets/1.json
  def update
    respond_to do |format|
      if @secret.update(secret_params)
        format.html { redirect_to @secret, notice: 'El secreto se actualizó correctamente.' }
        format.json { render :show, status: :ok, location: @secret }
      else
        format.html { render :edit }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secrets/1
  # DELETE /secrets/1.json
  def destroy
    @secret.destroy
    respond_to do |format|
      format.html { redirect_to secrets_url, notice: 'El secreto se eliminó correctamente.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_secret
    @secret = Secret.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def secret_params
    params.require(:secret).permit(:message, :key, :algorithm)
  end
end
