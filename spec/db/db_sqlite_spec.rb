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
    contacts = [contact_with_id(1), contact_with_id(2), contact_with_id(3)]
    db.add(contact)
    db.add(contact)
    db.add(contact)
    expect(db.all).to eq(contacts)
    expect(db.size).to eq(3)
  end

  def contact_with_id(id)
    new_contact       = {}
    new_contact["id"] = id
    new_contact.merge!(contact)
  end

end
