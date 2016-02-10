require 'menu'

describe Menu do

  let (:ui)      {instance_double(UI).as_null_object}
  let (:actions) {["one", "two"]}
  let (:menu)    {described_class.new(ui, actions)}

  it "clears the screen" do
    menu.clear
    expect(ui).to have_received(:clear).once
  end

  it "asks the user for a menu option" do
    menu.ask_menu_option
    expect(ui).to have_received(:ask_menu_option).once
  end

  it "creates a menu from a group of menu actions" do
  	expected = [
      [1, "one"],
      [2, "two"]
  	]
  	expect(menu.create_menu).to eq(expected)
  end

end
