require 'db/db'

describe DB do

  let(:reader)  {instance_double(Reader).as_null_object}
  let(:writer)  {instance_double(Writer).as_null_object}
  let(:db)      {described_class.new(reader, writer)}
  let(:contact) {{"name" => "name", "address" => "address"}}

  before :each do
    allow(reader).to receive(:read).and_return([])
  end

  it "returns an empty list of contacts if the reader is null" do
    db = described_class.new(nil, writer)
    expect(db.all).to eq([])
  end

  it "sends the list of all the contacts" do
    contacts = [
      {"id" => 1, "name" => "name1", "address" => "address1"},
      {"id" => 2, "name" => "name2", "address" => "address2"},
      {"id" => 3, "name" => "name3", "address" => "address3"}
    ]
    allow(reader).to receive(:read).and_return(contacts)
    expect(db.all).to eq(contacts)
  end

  it "gets an empty contact if the reader is null" do
    db = described_class.new(nil, writer)
    db.add(contact)
    expect(db.at(0)).to eq({})
  end

  it "gets an empty contact if there are no contacts" do
    expect(db.at(0)).to eq({})
  end

  it "gets an empty contact if the index is not valid" do
    db.add(contact)
    expect(db.size).to eq(1)
    expect(db.at(5)).to eq({})
  end

  it "gets one contact if there are contacts and the index is valid" do
    db.add(contact)
    contact_with_id = {"id" => 1, "name" => "name", "address" => "address"}
    expect(db.at(0)).to eq(contact_with_id)
  end

  it "adds one contact to the database" do
    db.add(contact)
    expect(db.size).to eq(1)
    expect(writer).to have_received(:run).once
  end

  it "first contact has an id of 1" do
    db.add(contact)
    expect(db.at(0)["id"]).to eq(1)
  end

  it "new contact has an id of previous contact id plus 1" do
    db.add(contact)
    db.add(contact)
    expect(db.at(0)["id"]).to eq(1)
    expect(db.at(1)["id"]).to eq(2)
  end

  it "appends a unique id to the contact if it doesn't have one" do
    contact_with_id = {"id" => 1, "name" => "name", "address" => "address"}
    db.add(contact)
    expect(db.at(0)).to eq(contact_with_id)
  end

  it "doesn't append a unique id to the contact if it already has one" do
    contact_with_id = {"id" => 1, "name" => "name", "address" => "address"}
    db.add(contact_with_id)
    expect(db.at(0)).to eq(contact_with_id)
  end

  it "finds the index of a contact with the same id as another" do
    contact_with_id = {"id" => 1, "name" => "name", "address" => "address"}
    db.add(contact)
    expect(db.index_of_id(contact_with_id["id"])).to eq(0)
  end

  it "updates a contact if a contact with the same id is passed" do
    contact_with_id = {"id" => 1, "name" => "new name", "address" => "new address"}
    db.update(contact)
    db.update(contact_with_id)
    expect(db.size).to eq(1)
    expect(db.at(0)).to eq(contact_with_id)
  end

  it "finds one contact given an exact term" do
    contacts = [
      {"id" => 1, "name" => "name1", "address" => "address1"},
      {"id" => 2, "name" => "name2", "address" => "address2"},
      {"id" => 3, "name" => "name3", "address" => "address3"}
    ]
    allow(reader).to receive(:read).and_return(contacts)
    expect(db.search("address1")).to eq([contacts.first])
  end

  it "finds several contacts given an inexact term" do
    contacts = [
      {"id" => 1, "name" => "name1", "address" => "address1"},
      {"id" => 2, "name" => "name2", "address" => "address2"},
      {"id" => 3, "name" => "name3", "address" => "address3"}
    ]
    allow(reader).to receive(:read).and_return(contacts)
    expect(db.search("address")).to eq(contacts)
  end

end