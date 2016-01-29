require 'menu'
require 'ui'

describe Menu do
  
  let (:ui)  {instance_double(UI).as_null_object}
  let(:menu) {Menu.new(ui)}

  it "prints the menu" do
    menu.display
    expect(ui).to have_received(:display_menu).once
  end
end