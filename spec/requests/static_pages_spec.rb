require 'spec_helper'

describe "Static Pages" do
  
  let(:base_title) { "SODMI |" }
  subject{ page }

  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }  
  end

  describe "Pagina de Inicio" do
    before{ visit root_path }
    let(:page_title) { '' }

    it { should have_content('REGISTRATE!') }
    it { should_not have_title('| Inicio') }
    it_should_behave_like "all static pages"

  end

  describe "Pagina de Contacto" do
    before{ visit contacto_path }
    let(:page_title) { 'Contacto' }

    it{ should have_content('Contacto') }
    it_should_behave_like "all static pages"

  end

  describe "Pagina de Lecciones" do
    before{ visit lecciones_path }
    let(:page_title) { 'Lecciones' }

    it{ should have_content('Lecciones') }
    it_should_behave_like "all static pages"

  end



  #test links

  it "los links deberian de enviar a las paginas correctas " do
    visit root_path
    click_link "Inicio"
    expect(page).to have_title(full_title(''))
    click_link "Contacto"
    expect(page).to have_title(full_title('Contacto'))
  end
  
end
