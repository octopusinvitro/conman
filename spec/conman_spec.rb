require 'conman'

describe Conman do

  let (:menu)   {instance_double(Menu).as_null_object}
  let (:conman) {described_class.new(menu)}

  it "asks the user for a menu option" do
    conman.run
    expect(menu).to have_received(:ask_menu_option).once
  end

  it "exits if the user types the exit option" do
    allow(menu).to receive(:exit).and_return(true)
    conman.run
    expect(menu).to have_received(:exit).once
  end

  it "checks the user option if it is not an exit option" do
    allow(menu).to receive(:exit).and_return(false, true)
    conman.run
    expect(menu).to have_received(:check).once
  end

  it "runs until the user types the exit option" do
    allow(menu).to receive(:exit).and_return(false, false, false, true)
    conman.run
    expect(menu).to have_received(:ask_menu_option).exactly(4).times
  end

end