require 'conman'
require 'ui'
require 'lister'
require 'creator'

describe Conman do

  let (:ui)      {instance_double(UI).as_null_object}
  let (:lister)  {instance_double(Lister).as_null_object}
  let (:creator) {instance_double(Creator).as_null_object}
  let (:finder)  {instance_double(Finder).as_null_object}
  let (:conman)  {Conman.new(ui, [lister, creator, finder])}

  it "displays menu once when program runs" do
    allow(ui).to receive(:ask_menu_option).and_return(4)
    conman.run
    expect(ui).to have_received(:ask_menu_option).once
  end

  it "calls 'list all contacts' if user selects to list all" do
    allow(ui).to receive(:ask_menu_option).and_return(1, 4)
    conman.run
    expect(lister).to have_received(:act).once
  end

  it "calls 'add contacts' if user selects to add a contact" do
    allow(ui).to receive(:ask_menu_option).and_return(2, 4)
    conman.run
    expect(creator).to have_received(:act).once
  end

  it "calls 'search contacts' if user selects to search for a contact" do
    allow(ui).to receive(:ask_menu_option).and_return(3, 4)
    conman.run
    expect(finder).to have_received(:act).once
  end

end