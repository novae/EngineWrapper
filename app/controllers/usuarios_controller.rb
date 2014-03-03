class UsuariosController < ApplicationController
  def index
  end
  
  def show
  	@usuario = Usuario.find(params[:id])
  end

  def new
  	@usuario = Usuario.new
  end

  def create
		@usuario = Usuario.new(user_params)
		if @usuario.save
			sign_in @usuario
			flash[:success] = "Bienvenido a SODMI! #{@usuario.nombre}"
			redirect_to @usuario
		else 
			render 'new'
		end
	end

	private

		def user_params
			params.require(:usuario).permit(:nombre,:email,:password,:password_confirmation)
		end
end
