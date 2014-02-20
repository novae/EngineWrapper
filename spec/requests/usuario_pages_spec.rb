require 'spec_helper'

describe "pagina de logeo" do
  subject { page }
  
  describe "pagina de logeo" do
  	before{ visit usuarios_new_path }

  	it{ should have_title('Ingresa!') }
  	it{ should have_content('Registrate!') }
  end
end
