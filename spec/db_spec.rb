require 'db'

describe DB do

  let(:reader) {instance_double(Reader).as_null_object}
  let(:writer) {instance_double(Writer).as_null_object}
  let(:db)     {described_class.new(reader, writer)}

  it "has a size of zero at the beginning" do
    allow(reader).to receive(:read_contacts).and_return([])
    expect(db.size).to eq(0)
  end

  it "adds one contact to the database" do
    contact = {name: "name", address: "address"}
    allow(reader).to receive(:read_contacts).and_return([contact])
    db.add(contact)
    expect(db.size).to eq(1)
    expect(writer).to have_received(:write_contacts).once
  end

  it "sends the list of all the contacts" do
    contacts = [
      {name: "name1", address: "address1"},
      {name: "name2", address: "address2"},
      {name: "name3", address: "address3"}
    ]
    allow(reader).to receive(:read_contacts).and_return(contacts)
    db = DB.new(reader, writer, contacts)
    expect(db.all).to eq(contacts)
    expect(reader).to have_received(:read_contacts).once
  end

  it "gets one contact by id" do
    contact = {name: "name", address: "address"}
    #allow(writer).to receive(:write_contacts).with([contact])
    db.add(contact)

    allow(reader).to receive(:read_contacts).and_return([contact])
    expect(db.at(0)).to eq(contact)
  end

end