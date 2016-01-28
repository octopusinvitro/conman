require 'conman'
require 'ui'

describe Conman do

  let (:ui) {instance_double(UI).as_null_object}
  let (:conman)  {Conman.new(ui)}

  it "saves the name introduced by the user" do
    allow(ui).to receive(:ask_for_name).and_return("name")
    conman.add_contact
    expect_field(:name, "name")
  end

  it "saves the address introduced by the user" do
    allow(ui).to receive(:ask_for_address).and_return("address")
    conman.add_contact
    expect_field(:address, "address")
  end

  it "saves the phone introduced by the user" do
    allow(ui).to receive(:ask_for_phone).and_return("123456")
    conman.add_contact
    expect_field(:phone, "123456")
  end

  it "saves the email introduced by the user" do
    allow(ui).to receive(:ask_for_email).and_return("email@mail.com")
    conman.add_contact
    expect_field(:email, "email@mail.com")
  end

  it "saves the notes introduced by the user" do
    allow(ui).to receive(:ask_for_notes).and_return("notes")
    conman.add_contact
    expect_field(:notes, "notes")
  end

  it "adds two contacts through the main loop" do
    allow(ui).to receive(:ask_for_another).and_return(true, false)
    allow(ui).to receive(:display)
    conman.run
    expect(conman.total_contacts).to eq(2)
  end

  it "prints contact after adding it" do
    allow(ui).to receive(:ask_for_another).and_return(false)
    allow(ui).to receive(:display)
    conman.run
    expect(ui).to have_received(:display).once
  end

  it "prints all contacts after finished" do
    allow(ui).to receive(:ask_for_another).and_return(true, false)
    allow(ui).to receive(:display)
    conman.run
    expect(ui).to have_received(:display_all).once
  end

  def expect_field(key, value)
    expect(conman.contact_of_id(0)[key]).to eq(value)
  end

end
