class Usuario < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :nombre, presence: true, length: { maximum:50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format:{ with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive:false }
	has_secure_password
	validates :password, length: {minimum:6}
	

	def Usuario.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Usuario.hash(token)
    	Digest::SHA1.hexdigest(token.to_s) 
  	end

  	private
			def create_remember_token
      		self.remember_token = Usuario.hash(Usuario.new_remember_token)
    	end

end
