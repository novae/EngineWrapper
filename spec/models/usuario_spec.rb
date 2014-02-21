require 'spec_helper'

describe Usuario do
	before { @usuario = Usuario.new(nombre:"usuario de ejemplo", email:"emaildeejemplo@ejemplo.com", 
									password: "foobar", password_confirmation:"foobar")}
	subject{ @usuario }

	# atributos miembro a los cuales deberia responder un objeto usuario
	it { should respond_to(:nombre) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should be_valid }

	#pruebas sobre la presencia de valores en los siguientes campos del formalario de ingreso
	
	describe "Cuando el valor en el campo nombre NO esta presente" do
		before { @usuario.nombre = "" }
		it { should_not be_valid }
	end

	describe "Cuando el valor en el campo email NO esta presente" do
		before { @usuario.email = "" }
		it { should_not be_valid }
	end

	#pruebas en las longitudes validas en los valores ingresados en el formulario de ingreso

	describe "El nombre de usuario no deberia ser muy largo" do
		before { @usuario.nombre = "a" * 51 }
		it { should_not be_valid }
	end

	describe "Cuando el password es demasiado corto" do
		before { @usuario.password = "a" * 5 }
		it { should be_invalid }
	end	
	
	describe "cuando una direccion de correo electronico es valida" do
		
		it "deberia ser invalida" do
			direcciones = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
            direcciones.each do |direcciones_invalidas|        
            	@usuario.email = direcciones_invalidas
            	expect(@usuario).not_to be_valid
            end
		end

		it "Cuando un formato es valido" do
			direcciones = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			direcciones.each do |direcciones_validas|
				@usuario.email = direcciones_validas
				expect(@usuario).to be_valid
			end
		end

	end

	describe "Cuando una direccion de correo electronico ya ha sido tomada" do
		before do
			usuario_con_mismo_correro =  @usuario.dup
			usuario_con_mismo_correro.email = @usuario.email.upcase
			usuario_con_mismo_correro.save
		end

		it { should_not be_valid }
	end

	describe "cuando el password no ha sido proporcionado" do
		before do
			@usuario = Usuario.new(nombre:"jc", email:"jc@ejemplo.com",
									password: " ", password_confirmation:" ")
		end
		it{ should_not be_valid }
	end

	describe "cuando el password-password_confirmation no son identicos" do
		before { @usuario.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "valor de retorno del metodo de autenticacion" do
		before { @usuario.save }
		let(:usuario_encontrado) { Usuario.find_by(email: @usuario.email) }

		describe "con un password valido" do
			it { should eq usuario_encontrado.authenticate(@usuario.password) }	
		end

		describe "con un password invalido" do
			let(:usuario_con_password_invalido) { usuario_encontrado.authenticate("invalid") } 
			it { should_not eq usuario_con_password_invalido } 
			specify { expect(usuario_con_password_invalido).to be_false}
		end
	end

end







































