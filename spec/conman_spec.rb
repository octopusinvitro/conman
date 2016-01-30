require 'conman'
require 'ui'
require 'db'
require 'creator'

describe Conman do

  let (:ui)       {instance_double(UI).as_null_object}
  let (:db)       {DB.new}
  let (:conman)   {Conman.new(ui, db, Creator.new(ui, db))}
  let (:contacts) {[
    {name: "name1", address: "address1"},
    {name: "name2", address: "address2"},
    {name: "name3", address: "address3"}
  ]}

  before :each do
    allow(ui).to receive(:ask_for_another).and_return(false)
    allow(ui).to receive(:display)
  end

  it "finds a contact given an exact term" do
    db     = DB.new(contacts)
    conman = Conman.new(ui, db, Creator.new(ui, db))
    expect(conman.search_contact("address1")).to eq([contacts.first])
  end

  it "finds several contacts given an inexact term" do
    db     = DB.new(contacts)
    conman = Conman.new(ui, db, Creator.new(ui, db))
    expect(conman.search_contact("address")).to eq(contacts)
  end

  it "performs two searches" do
    allow(ui).to receive(:ask_search_again).and_return(true, false)
    conman.search_contacts
    expect(ui).to have_received(:ask_search_again).twice
  end

  it "prints all found contacts after a search" do
    allow(ui).to receive(:ask_search_again).and_return(false)
    conman.search_contacts
    expect(ui).to have_received(:display_all).once
  end

  it "displays menu once when program runs" do
    allow(ui).to receive(:ask_menu_option).and_return(3)
    conman.run
    expect(ui).to have_received(:ask_menu_option).once
  end

  it "calls add contacts if user selects 1" do
    allow(ui).to receive(:ask_menu_option).and_return(1, 3)
    conman.run
    expect(ui).to have_received(:ask_for_name).once
  end

  it "calls search contacts if user selects 2" do
    allow(ui).to receive(:ask_menu_option).and_return(2, 3)
    allow(ui).to receive(:ask_search_again).and_return(false)
    conman.run
    expect(ui).to have_received(:ask_for_term).once
  end

end