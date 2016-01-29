require 'menu'
require 'ui'

describe Menu do
  
  let (:ui)  {instance_double(UI).as_null_object}
  let(:menu) {Menu.new(ui)}

  it "prints the menu" do
    menuOptions = [["1", "Option 1"], ["2", "Option 2"]]
    menu.ask_menu_option(menuOptions)
    expect(ui).to have_received(:ask_menu_option).once
  end
end