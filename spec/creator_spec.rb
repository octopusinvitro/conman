require 'creator'

describe Creator do

  let (:ui)       {instance_double(UI).as_null_object}
  let (:db)       {instance_double(DB).as_null_object}
  let (:creator)  {described_class.new(ui, db)}
  let (:contact)  {{"name" => "name", "address" => "address", "phone" => "123456", "email" => "email@mail.com", "notes" => "notes"}}

  before :each do
    allow(ui).to receive(:ask_for_another).and_return(false)
    allow(db).to receive(:at).and_return(contact)
  end

  it "saves the name introduced by the user" do
    allow(ui).to receive(:ask_for_name).and_return("name")
    creator.act
    expect_field("name", "name")
  end

  it "saves the address introduced by the user" do
    allow(ui).to receive(:ask_for_address).and_return("address")
    creator.act
    expect_field("address", "address")
  end

  it "saves the phone introduced by the user" do
    allow(ui).to receive(:ask_for_phone).and_return("123456")
    creator.act
    expect_field("phone", "123456")
  end

  it "saves the email introduced by the user" do
    allow(ui).to receive(:ask_for_email).and_return("email@mail.com")
    creator.act
    expect_field("email", "email@mail.com")
  end

  it "saves the notes introduced by the user" do
    allow(ui).to receive(:ask_for_notes).and_return("notes")
    creator.act
    expect_field("notes", "notes")
  end

  it "adds two contacts" do
    allow(ui).to receive(:ask_for_another).and_return(true, false)
    creator.act
    expect(db).to have_received(:add).twice
  end

  it "prints one contact after adding it and all contacts after finished" do
    creator.act
    expect(ui).to have_received(:display_all).twice
  end

  it "prints two contacts after adding them and after finished" do
    allow(ui).to receive(:ask_for_another).and_return(true, false)
    creator.act
    expect(ui).to have_received(:display_all).exactly(3).times
  end

  def expect_field(key, value)
    expect(db.at(0)[key]).to eq(value)
  end
end