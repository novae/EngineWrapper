module SessionsHelper
	
	def sign_in(usuario)
    remember_token = Usuario.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    usuario.update_attribute(:remember_token, Usuario.hash(remember_token))
    self.current_user = usuario
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = Usuario.hash(cookies[:remember_token])
    @current_user ||= Usuario.find_by(remember_token: remember_token)
  end

  def current_user?(usuario)
    usuario == current_user
  end

  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    current_user.update_attribute(:remember_token,
                                  Usuario.hash(Usuario.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default) 
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
