
require 'spec_helper'

describe "Usuario pages" do
  
  subject { page }

  describe "profile page" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before { visit usuario_path(usuario) }

    it { should have_content(usuario.nombre) }
    it { should have_title(usuario.nombre) }
  end
  
  describe "signup page" do
    before{ visit  signup_path }

    it{ should have_title('Registrate!') }
    it{ should have_content('REGISTRATE!') }
  end

  

  describe "signup" do
    
    before { visit signup_path }
    
    let(:submit) { "Crear" }

    describe "with invalid information" do
      it "should not create a user" do
        expect{ click_button submit }.not_to change(Usuario, :count)
      end
    end

    describe "with valid information" do 
      before do
        fill_in "nombre",                 with:"novae"
        fill_in "email",                  with:"novaegr2@gmail.com"
        fill_in "password",               with:"foobarbaz"
        fill_in "password_confirmation",           with:"foobarbaz"
      end

      it "should create  a user" do
        expect { click_button submit }.to change(Usuario, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:usuario) { Usuario.find_by(email:'novaegr2@gmail.com') }

        it { should have_link('Salir') }
        it { should have_title(usuario.nombre) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
      end
    end
  end

  describe 'edit' do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before do
      sign_in usuario
      visit edit_usuario_path(usuario) 
    end

    describe "page" do
      it { should have_content("Actualiza tu perfil") }
      it { should have_title("Editar perfil de usuario") }
      it { should have_link('Cambiar', href:'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Guardar cambios" }
      it { should have_content('error')}
    end

    describe "with valid information" do
      let(:new_name)  { "novae_Jc" }
      let(:new_email) { "novaegr@hotmail.com" }
      before do
        fill_in "nombre",                 with:new_name
        fill_in "email",                  with:new_email
        fill_in "password",               with:usuario.password
        fill_in "password_confirmation",  with:usuario.password
        click_button "Guardar cambios"
      end

      it      { should have_title(new_name) }
      it      { should have_selector('div.alert.alert-success') }
      it      { should have_link('Salir', href:signout_path) }
      specify { expect(usuario.reload.nombre).to eq new_name }
      specify { expect(usuario.reload.email).to eq new_email }
    end

  end

  describe "index page" do
    before do
      sign_in FactoryGirl.create(:usuario)
      FactoryGirl.create(:usuario, nombre:"ivan",email:"ivan@gmail.com")
      FactoryGirl.create(:usuario, nombre:"cynthia", email:"cynthia@gmail.com")
      visit usuarios_path
    end

    it { should have_title('Usuarios') }
    it { should have_content('Usuarios') }

    describe "pagination" do
      
      before(:all) { 30.times { FactoryGirl.create(:usuario) } }
      after(:all) { Usuario.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        Usuario.paginate(page: 1).each do |usuario|
          expect(page).to have_selector('li', text:usuario.nombre)
        end
      end
    end
  end

end
