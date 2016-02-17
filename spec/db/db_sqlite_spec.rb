require 'db/db_sqlite'

describe DBSQLite do

  let (:db)      {described_class.new(":memory:")}
  let (:contact) {{"name" => "a name", "address" => "an address", "phone" => "123456", "email" => "email@mail.com", "notes" => "some notes"}}

  it "returns an empty array if database is empty" do
    expect(db.all).to eq([])
  end

  it "adds one contact to the database" do
    db.add(contact)
    expect(db.all).to eq([contact_with_id(1)])
  end

  it "retrieves all contacts" do
    db.add(contact)
    db.add(contact)
    db.add(contact)
    contacts = [contact_with_id(1), contact_with_id(2), contact_with_id(3)]
    expect(db.all).to eq(contacts)
    expect(db.size).to eq(3)
  end

  it "gets an empty contact if there are no contacts in the db" do
    expect(db.at(0)).to eq({})
  end

  it "gets an empty contact if the index is not valid" do
    db.add(contact)
    expect(db.size).to eq(1)
    expect(db.at(5)).to eq({})
  end

  it "gets one contact if there are contacts and the index is valid" do
    db.add(contact)
    expect(db.at(0)).to eq(contact_with_id(1))
  end

  it "updates a contact if a contact with the same id is passed" do
    db.add(contact)
    contact["name"] = "new name"
    db.update(contact_with_id(1))
    expect(db.size).to eq(1)
    expect(db.at(0)["name"]).to eq("new name")
  end

  it "finds one contact given an exact term" do
    db.add(contact)

    contact2 = contact
    contact2["address"] = "address2"
    db.add(contact2)

    contact3 = contact
    contact3["address"] = "address3"
    db.add(contact3)

    expect(db.search("address3")).to eq([db.all.last])
  end

  it "finds several contacts given an inexact term" do
    db.add(contact)

    contact2 = contact
    contact2["address"] = "address2"
    db.add(contact2)

    contact3 = contact
    contact3["address"] = "address3"
    db.add(contact3)

    expect(db.search("address")).to eq(db.all)
  end

  def contact_with_id(id)
    new_contact       = {}
    new_contact["id"] = id
    new_contact.merge!(contact)
  end

end
