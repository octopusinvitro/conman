require 'conman'

describe Conman do

  let (:menu)       {instance_double(Menu).as_null_object}
  let (:lister)     {instance_double(Lister).as_null_object}
  let (:terminator) {instance_double(Terminator).as_null_object}
  let (:actions)    {[lister, terminator]}
  let (:conman)     {described_class.new(menu, actions)}

  it "asks the user for a menu option" do
    allow(menu).to receive(:ask_menu_option).and_return(2)
    conman.body
    expect(menu).to have_received(:ask_menu_option).once
  end

  it "chooses the right action for a user option" do
    allow(menu).to receive(:ask_menu_option).and_return(1)
    conman.body
    expect(lister).to have_received(:run).once
  end

end