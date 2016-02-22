require 'ui/ui'
require 'db/db_file'
require 'screens/creator'

describe Creator do

  let(:ui)       {instance_double(UI).as_null_object}
  let(:db)       {instance_double(DBFile).as_null_object}
  let(:creator)  {described_class.new(ui, db)}
  let(:contact)  {{"id" => 1, "name" => "a name", "address" => "an address", "phone" => "123456", "email" => "email@mail.com", "notes" => "some notes"}}

  before :each do
    allow(ui).to receive(:ask_for_another).and_return(false)
    allow(db).to receive(:at).and_return(contact)
  end

  it "saves the name introduced by the user" do
    creator.run
    expect_field("name", "a name")
  end

  it "saves the address introduced by the user" do
    creator.run
    expect_field("address", "an address")
  end

  it "saves the phone introduced by the user" do
    creator.run
    expect_field("phone", "123456")
  end

  it "saves the email introduced by the user" do
    creator.run
    expect_field("email", "email@mail.com")
  end

  it "saves the notes introduced by the user" do
    creator.run
    expect_field("notes", "some notes")
  end

  it "adds two contacts" do
    allow(ui).to receive(:ask_for_another).and_return(true, false)
    creator.run
    expect(db).to have_received(:add).twice
  end

  it "prints one contact after adding it and all contacts after finished" do
    creator.run
    expect(ui).to have_received(:display_all).twice
  end

  it "prints two contacts after adding them and after finished" do
    allow(ui).to receive(:ask_for_another).and_return(true, false)
    creator.run
    expect(ui).to have_received(:display_all).exactly(3).times
  end

  def expect_field(key, value)
    expect(db.at(0)[key]).to eq(value)
  end

end
