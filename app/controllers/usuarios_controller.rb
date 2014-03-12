class UsuariosController < ApplicationController
	before_action :signed_in_user,	only:[:index, :edit, :update]
	before_action :correct_user,		only:[:edit, :update]

  def index
    @usuarios = Usuario.paginate(page: params[:page])
  end
  
  def show
  	@usuario = Usuario.find(params[:id])
  end

  def new
  	@usuario = Usuario.new
  end

  def edit
  	@usuario = Usuario.find(params[:id])
  end

  def update
  	@usuario = Usuario.find(params[:id])
  	if @usuario.update_attributes(user_params)
  		flash[:success] = "Perfil actualizado"
      redirect_to @usuario
  	else
  		render 'edit'
  	end
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

		def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Porfavor Ingrese a su cuenta"
      end
		end

		def correct_user
      @usuario = Usuario.find(params[:id])
      redirect_to(root_url) unless current_user?(@usuario)
    end


end
