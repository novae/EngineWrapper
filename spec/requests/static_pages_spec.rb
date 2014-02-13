require 'spec_helper'

describe "Static Pages" do
  
  let(:base_title) { "SODMI |" }

  describe "Pagina de Inicio" do
    it "Deberia tener el contenido 'SODMI'" do
      visit '/static_pages/Inicio'
      expect(page).to have_content('SODMI')
    end

    it "Deberia tener el titulo correcto" do
    	visit '/static_pages/Inicio'
    	expect(page).to have_title("SODMI")
    end

    it "No deberia tener el titulo personalizado" do
    	visit '/static_pages/Inicio'
    	expect(page).not_to have_title('| Inicio')
    end
  end

  describe "Pagina de Contacto" do
    it "Deberia tener el contenido 'SODMI'" do
      visit '/static_pages/Contacto'
      expect(page).to have_content('Contacto')
    end

    it "Deberia tener el titulo correcto" do
    	visit '/static_pages/Contacto'
    	expect(page).to have_title("#{base_title} Contacto")
    end
  end

  describe "Pagina de Inicio" do
    it "Deberia tener el contenido 'SODMI'" do
      visit '/static_pages/Lecciones'
      expect(page).to have_content('Lecciones')
    end

    it "Deberia tener el titulo correcto" do
    	visit '/static_pages/Lecciones'
    	expect(page).to have_title("#{base_title} Lecciones")
    end
  end
  
end
