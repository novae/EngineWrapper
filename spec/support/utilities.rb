def full_title(page_title)
		base_title = "SODMI"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
end

def sign_in(usuario, options={})
  if options[:no_capybara]
    remember_token = Usuario.new_remember_token
    cookies[:remember_token] = remember_token
    usuario.update_attribute(:remember_token, Usuario.hash(remember_token))
  else
    visit signin_path
    fill_in "email",    with: usuario.email
    fill_in "password", with: usuario.password
    click_button "Entrar"
  end
end