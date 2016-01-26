require 'conman'

describe Conman do

  it "saves the name introduced by the user" do
    input  = StringIO.new("name\n")
    output = StringIO.new

    console = Console.new(input, output)
    conman  = Conman.new(console)
    
    conman.add_contact
    expect(conman.contact_by_id(0)[:name]).to eq("name")
  end

end