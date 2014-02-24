
require 'spec_helper'

describe "pagina de logeo" do
  subject { page }
  
  describe "pagina de logeo" do
  	before{ visit new_usuario_path }

  	it{ should have_title('Ingresa!') }
  	it{ should have_content('REGISTRATE!') }
  end

  describe "pagina de perfil" do
    let(:usuario){ FactoryGirl.create(:usuario) }
    before { visit usuario_path(usuario) }
    it { should have_content(usuario.nombre) }
    it { should have_title(usuario.nombre) }
  end

  describe "formulario para crear cuenta en SODMI" do
    before { visit ingresar_path }
    let(:submit) { "Crear" }

    describe "con informacion erronea" do
      it "no deberia crear un usuario" do
        expect{ click_button submit }.not_to change(Usuario, :count)
      end
    end

    describe "deberia crear un usuario" do 
      before do
        fill_in "nombre",               with:"novae"
        fill_in "email",   with:"novaegr2@gmail.com"
        fill_in "password",           with:"foobarbaz"
        fill_in "password_confirmation", with:"foobarbaz"
      end

      it "should create  a user" do
        expect { click_button submit }.to change(Usuario, :count).by(1)
      end
    end

  end
end
