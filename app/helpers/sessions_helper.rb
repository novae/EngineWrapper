module SessionsHelper
	
	def sign_in(user)
    remember_token = Usuario.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Usuario.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
  	current_user.update_attribute(:remember_token, Usuario.encrypt(Usuario.new_remember_token))
  	cookies.delete(:remember_token)
  	self.current_user = nil
  end
  	
  def current_user=(user)
    @current_user = user
  end
	
  def current_user
    remember_token = Usuario.encrypt(cookies[:remember_token])
    @current_user ||= Usuario.find_by(remember_token: remember_token)
  end
	
 	def signed_in?
    !current_user.nil?
  end
end
