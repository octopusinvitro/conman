require 'db'

describe DB do

  let(:reader) {instance_double(Reader).as_null_object}
  let(:writer) {instance_double(Writer).as_null_object}
  let(:db)     {described_class.new(reader, writer)}

  before :each do
    allow(reader).to receive(:read_contacts).and_return([])
  end

  it "adds one contact to the database" do
    contact = {"name" => "name", "address" => "address"}
    db.add(contact)
    expect(db.size).to eq(1)
    expect(writer).to have_received(:write_contacts).once
  end

  it "adds two contacts to the database" do
    contact = {"name" => "name", "address" => "address"}
    db.add(contact)
    db.add(contact)
    expect(db.size).to eq(2)
    expect(writer).to have_received(:write_contacts).twice
  end

  it "returns an empty list of contacts if the reader is null" do
    db = described_class.new(nil, writer)
    expect(db.all).to eq([])
  end

  it "sends the list of all the contacts" do
    contacts = [
      {"name" => "name1", "address" => "address1"},
      {"name" => "name2", "address" => "address2"},
      {"name" => "name3", "address" => "address3"}
    ]
    allow(reader).to receive(:read_contacts).and_return(contacts)
    expect(db.all).to eq(contacts)
  end

  it "gets an empty contact if the reader is null" do
    db = described_class.new(nil, writer)
    db.add({"name" => "name", "address" => "address"})
    expect(db.at(0)).to eq({})
  end

  it "if everything goes well, gets one contact by id" do
    contact = {"name" => "name", "address" => "address"}
    db.add(contact)

    allow(reader).to receive(:read_contacts).and_return([contact])
    expect(db.at(0)).to eq(contact)
  end

end