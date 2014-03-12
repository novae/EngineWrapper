require 'spec_helper'

describe "Authentication" do
  
  subject { page }

  describe "signin page" do
  	before { visit signin_path }
    
    it { should have_content('Entrar') }
    it { should have_title('Entrar') }
  end
    
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Entrar"} 
      
      it { should have_title('Entrar') }  
      it { should have_selector('div.alert.alert-danger', text:'incorrectos') }

      describe "after visiting another page" do
        before { click_button "Entrar" }
        it { should have_selector('div.alert.alert-danger') }
      end
    end  

    describe "with valid information" do
      let(:usuario) { FactoryGirl.create(:usuario) }
     before { sign_in usuario }

      it { should have_title(usuario.nombre) }
      it { should have_link('Perfil',         href: usuario_path(usuario)) }
      it { should have_link('Usuarios',       href: usuarios_path  )}
      it { should have_link('Configuracion',  href: edit_usuario_path(usuario)) }
      it { should have_link('Salir',          href: signout_path) }
      it { should_not have_link('Entrar',     href: signin_path) }

      describe "followed by signout" do
        before { click_link "Salir" }
        it { should have_link('Entrar') }
      end
    end
  end

  describe "Authorization" do

    describe "for non-signed-in users" do
      let(:usuario) { FactoryGirl.create(:usuario) }

      describe "when attempting to visit a protected page" do 
        before do
          visit edit_usuario_path(usuario)
          fill_in "email",    with:usuario.email
          fill_in "password",  with:usuario.password
          click_button "Entrar"
        end

        describe "after signing in" do 
          it "should render the desired protected page" do
            expect(page).to have_title('Editar perfil de usuario')
          end
        end
      end

      describe "in the Usuario controller" do

        describe "visiting the edit page" do
          before { visit edit_usuario_path(usuario) }
          it { should have_title('Entrar') } 
        end
        
        describe "submitting to the update action" do
          before { patch usuario_path(usuario) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index"  do
          before { visit usuarios_path }
          it { should have_title('Entrar')}
        end
        
      end

      
    end

    describe "as wrong user" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      let(:wronguser) { FactoryGirl.create(:usuario, email:"wronguser@wrong.com") }
      before { sign_in usuario, no_capybara: true }

      describe "submitting a GET request to the usuarios#edit action" do
        before { get edit_usuario_path(wronguser) }
        specify { expect(response.body).not_to match(full_title('Editar perfil de usuario')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the usuarios#update action" do
        before { patch usuario_path(wronguser) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

  end
    
end
  