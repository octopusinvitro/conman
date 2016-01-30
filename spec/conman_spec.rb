require 'conman'
require 'ui'

describe Conman do

  let (:ui)       {instance_double(UI).as_null_object}
  let (:conman)   {Conman.new(ui)}
  let (:contacts) {[
    {name: "name1", address: "address1"},
    {name: "name2", address: "address2"},
    {name: "name3", address: "address3"}
  ]}

  before :each do
    allow(ui).to receive(:ask_for_another).and_return(false)
    allow(ui).to receive(:display)
  end

  it "saves the name introduced by the user" do
    allow(ui).to receive(:ask_for_name).and_return("name")
    conman.add_contacts
    expect_field(:name, "name")
  end

  it "saves the address introduced by the user" do
    allow(ui).to receive(:ask_for_address).and_return("address")
    conman.add_contacts
    expect_field(:address, "address")
  end

  it "saves the phone introduced by the user" do
    allow(ui).to receive(:ask_for_phone).and_return("123456")
    conman.add_contacts
    expect_field(:phone, "123456")
  end

  it "saves the email introduced by the user" do
    allow(ui).to receive(:ask_for_email).and_return("email@mail.com")
    conman.add_contacts
    expect_field(:email, "email@mail.com")
  end

  it "saves the notes introduced by the user" do
    allow(ui).to receive(:ask_for_notes).and_return("notes")
    conman.add_contacts
    expect_field(:notes, "notes")
  end

  it "adds two contacts" do
    allow(ui).to receive(:ask_for_another).and_return(true, false)
    conman.add_contacts
    expect(conman.total_contacts).to eq(2)
  end

  it "prints contact after adding it" do
    conman.add_contacts
    expect(ui).to have_received(:display).once
  end

  it "prints all contacts after finished" do
    conman.add_contacts
    expect(ui).to have_received(:display_all).once
  end

  it "finds a contact given an exact term" do
    conman = Conman.new(ui, contacts)
    expect(conman.search_contact("address1")).to eq([contacts.first])
  end

  it "finds several contacts given an inexact term" do
    conman = Conman.new(ui, contacts)
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

  def expect_field(key, value)
    expect(conman.contact_of_id(0)[key]).to eq(value)
  end

end
