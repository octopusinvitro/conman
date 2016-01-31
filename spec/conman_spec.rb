require 'conman'
require 'ui'
require 'db'
require 'lister'
require 'creator'

describe Conman do

  let (:ui)     {instance_double(UI).as_null_object}
  let (:db)     {DB.new([{name: "name"}])}
  let (:conman) {Conman.new(ui, db)}

  before :each do
    allow(ui).to receive(:ask_for_another).and_return(false)
    allow(ui).to receive(:display)
  end

  it "displays menu once when program runs" do
    allow(ui).to receive(:ask_menu_option).and_return(4)
    conman.run
    expect(ui).to have_received(:ask_menu_option).once
  end

  it "calls 'list all contacts' if user selects to list all" do
    allow(ui).to receive(:ask_menu_option).and_return(1, 4)
    conman.run
    expect(ui).to have_received(:display_all).once
  end

  it "calls 'add contacts' if user selects to add a contact" do
    allow(ui).to receive(:ask_menu_option).and_return(2, 4)
    conman.run
    expect(ui).to have_received(:ask_for_name).once
  end

  it "calls 'search contacts' if user selects to search for a contact" do
    allow(ui).to receive(:ask_menu_option).and_return(3, 4)
    allow(ui).to receive(:ask_for_term).and_return("")
    allow(ui).to receive(:ask_to_expand).and_return(false)
    allow(ui).to receive(:ask_search_again).and_return(false)
    conman.run
    expect(ui).to have_received(:ask_for_term).once
  end

end