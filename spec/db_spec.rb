require 'db'

describe DB do

  let(:db) {DB.new()}

  it "has a size of zero at the beginning" do
    expect(db.size).to eq(0)
  end

  it "adds one contact to the database" do
    contact = {name: "name", address: "address"}
    db.add(contact)
    expect(db.size).to eq(1)
  end

  it "sends the list of all the contacts" do
    contacts = [
      {name: "name1", address: "address1"},
      {name: "name2", address: "address2"},
      {name: "name3", address: "address3"}
    ]
    db = DB.new(contacts)
    expect(db.all).to eq(contacts)
  end

  it "gets one contact by id" do
    contact = {name: "name", address: "address"}
    db.add(contact)
    expect(db.at(0)).to eq(contact)
  end

end