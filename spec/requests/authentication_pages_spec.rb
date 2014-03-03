require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "signin page" do
  	before {visit entrar_path}

    describe "with invalid information" do
      before { click_button "Entrar"} 
      it { should have_content('Entrar') }
      it { should have_title('Entrar')}
      it { should have_selector('div.alert.alert-danger'), text:'incorrectos' }

      describe "Despues de visitar otra pagina" do
        before { click_link 'Inicio' }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      before do
        fill_in "email",    with:usuario.email.upcase
        fill_in "password", with:usuario.password
        click_button "Entrar"
      end

      it { should have_title(usuario.nombre) }
      it { should have_link('Perfil',     href: usuario_path(usuario)) }
      it { should have_link('Salir',      href: salir_path) }
      it { should_not have_link('Entrar', href:entrar_path) }

      describe "followed by signout" do
        before { click_link "Salir" }
        it { should have_link('Entrar') }
      end
    end
  end
end
