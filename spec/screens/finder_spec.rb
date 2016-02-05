require 'screens/finder'

describe FinderScreen do

  let (:contacts) {[
    {"name" => "name1", "address" => "address1"},
    {"name" => "name2", "address" => "address2"},
    {"name" => "name3", "address" => "address3"}
  ]}
  let (:ui)     {instance_double(UI).as_null_object}
  let (:db)     {instance_double(DB).as_null_object}
  let (:finder) {described_class.new(ui, db)}

  before :each do
    allow(db).to receive(:search).and_return(contacts)
    allow(ui).to receive(:ask_for_term).and_return("")
    allow(ui).to receive(:ask_to_expand).and_return(false)
    allow(ui).to receive(:ask_search_again).and_return(false)
  end

  it "performs two searches" do
    allow(ui).to receive(:ask_search_again).and_return(true, false)
    finder.run
    expect(ui).to have_received(:ask_search_again).twice
  end

  it "prints an error message if there are no contacts matching search" do
    allow(db).to receive(:search).and_return([])
    finder.run
    expect(ui).to have_received(:error_no_contacts).once
  end

  it "prints names of all found contacts after a search" do
    finder.run
    expect(ui).to have_received(:display_names).once
  end

  it "asks for more details from a contact in the search results" do
    allow(ui).to receive(:ask_to_expand).and_return(true)
    allow(ui).to receive(:ask_for_contact).and_return(1)
    finder.run
    expect(ui).to have_received(:ask_to_expand).once
  end

  it "displays a specific contact if the user chooses one" do
    allow(ui).to receive(:ask_to_expand).and_return(true)
    allow(ui).to receive(:ask_for_contact).and_return(1)
    finder.run
    expect(ui).to have_received(:display_all).once
  end

  it "chooses the correct contact to display from the search results" do
    allow(db).to receive(:search).and_return([contacts[2]])
    allow(ui).to receive(:ask_to_expand).and_return(true)
    allow(ui).to receive(:ask_for_contact).and_return(1)
    finder.run
    expect(ui).to have_received(:display_all).with([contacts[2]])
  end

end