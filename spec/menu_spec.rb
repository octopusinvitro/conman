require 'menu'

describe Menu do

  let (:ui)     {instance_double(UI).as_null_object}
  let (:lister) {instance_double(Lister).as_null_object}
  let (:actions) {[
    ["one", lister],
    ["two", nil]
  ]}
  let (:menu) {Menu.new(ui, actions)}

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

  it "exits when the user chooses the last menu option" do
    expect(menu.exit(actions.size)).to eq(true)
  end

  it "does not exit when user doesn't choose the last menu option" do
    expect(menu.exit(1)).to eq(false)
  end

  it "calls the action corresponding to the user option" do
    menu.check(1)
    expect(lister).to have_received(:act).once
  end

end
