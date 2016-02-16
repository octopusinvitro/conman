require 'db/db_sqlite'

describe DBSQLite do

  it "returns an empty array if database is empty" do
    db = DBSQLite.new(":memory:")
    expect(db.all).to eq([])
  end

end
