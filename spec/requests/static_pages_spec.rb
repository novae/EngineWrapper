require 'spec_helper'

describe "Static Pages" do
  
  let(:base_title) { "SODMI |" }
  subject{ page }

  describe "Pagina de Inicio" do
    before{ visit root_path }
    
    it { should have_content('REGISTRATE!') }
    it { should have_title(full_title('')) }  
    it { should_not have_title('| Inicio') }
  
  end

  describe "Pagina de Contacto" do
    before{ visit contacto_path }
    
    it{ should have_content('Contacto') }
    it{ should have_title(full_title('Contacto')) }

  end

  describe "Pagina de Inicio" do
    before{ visit lecciones_path }

    it{ should have_content('Lecciones') }
    it{ should have_title(full_title('Lecciones')) }

  end
  
end
