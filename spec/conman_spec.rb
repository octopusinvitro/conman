require 'conman'
require 'ui'
require 'db'
require 'creator'

describe Conman do

  let (:ui)     {instance_double(UI).as_null_object}
  let (:db)     {DB.new}
  let (:conman) {Conman.new(ui, Creator.new(ui, db), Finder.new(ui, db))}

  before :each do
    allow(ui).to receive(:ask_for_another).and_return(false)
    allow(ui).to receive(:display)
  end

  it "displays menu once when program runs" do
    allow(ui).to receive(:ask_menu_option).and_return(3)
    conman.run
    expect(ui).to have_received(:ask_menu_option).once
  end

  it "calls add contacts if user selects 1" do
    allow(ui).to receive(:ask_menu_option).and_return(1, 3)
    conman.run
    expect(ui).to have_received(:ask_for_name).once
  end

  it "calls search contacts if user selects 2" do
    allow(ui).to receive(:ask_menu_option).and_return(2, 3)
    allow(ui).to receive(:ask_search_again).and_return(false)
    conman.run
    expect(ui).to have_received(:ask_for_term).once
  end

end