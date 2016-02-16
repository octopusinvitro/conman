require 'db/db_sqlite'

describe DBSQLite do


  let (:db)              {DBSQLite.new(":memory:")}
  let (:contact)         {{"name" => "a name", "address" => "an address", "phone" => "123456", "email" => "email@mail.com", "notes" => "some notes"}}
  let (:contact_with_id) {{"id" => 1, "name" => "a name", "address" => "an address", "phone" => "123456", "email" => "email@mail.com", "notes" => "some notes"}}

  it "returns an empty array if database is empty" do
    expect(db.all).to eq([])
  end

  it "adds one contact to the database" do
    db.add(contact)
    expect(db.all).to eq([contact_with_id])
  end

end
