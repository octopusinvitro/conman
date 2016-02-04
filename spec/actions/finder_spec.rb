require 'actions/finder'

describe Finder do

  let (:contacts) {[
    {"name" => "name1", "address" => "address1"},
    {"name" => "name2", "address" => "address2"},
    {"name" => "name3", "address" => "address3"}
  ]}
  let (:ui)     {instance_double(UI).as_null_object}
  let (:db)     {instance_double(DB).as_null_object}
  let (:finder) {described_class.new(ui, db)}

  before :each do
    allow(db).to receive(:all).and_return(contacts)
    allow(ui).to receive(:ask_for_term).and_return("")
    allow(ui).to receive(:ask_to_expand).and_return(false)
    allow(ui).to receive(:ask_search_again).and_return(false)
  end

  it "finds one contact given an exact term" do
    expect(finder.search_contact("address1")).to eq([contacts.first])
  end

  it "finds several contacts given an inexact term" do
    expect(finder.search_contact("address")).to eq(contacts)
  end

  it "performs two searches" do
    allow(ui).to receive(:ask_search_again).and_return(true, false)
    finder.run
    expect(ui).to have_received(:ask_search_again).twice
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
    allow(ui).to receive(:ask_for_term).and_return("address3")
    allow(ui).to receive(:ask_to_expand).and_return(true)
    allow(ui).to receive(:ask_for_contact).and_return(1)
    finder.run
    expect(ui).to have_received(:display_all).with([contacts.at(2)])
  end

end