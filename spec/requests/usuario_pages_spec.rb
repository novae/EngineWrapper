require 'spec_helper'

describe "pagina de logeo" do
  subject { page }
  
  describe "pagina de logeo" do
  	before{ visit usuarios_new_path }

  	it{ should have_title('Ingresa!') }
  	it{ should have_content('REGISTRATE!') }
  end

  it "los links deberian de enviar a las paginas correctas " do
  	visit usuarios_new_path
  	expect(page).to have_title(full_title('Ingresa!'))
  end
end
