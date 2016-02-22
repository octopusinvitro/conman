require 'ui/console'

describe Console  do

  it "prints to the console" do
    output  = StringIO.new
    console = described_class.new(nil, output)
    console.write("boo")
		
    expect(output.string).to eq("boo")
  end

  it "prints a line to the console" do
    output  = StringIO.new
    console = described_class.new(nil, output)
    console.writeln("boo")

    expect(output.string).to eq("boo\n")
  end

  it "reads from console" do
    input   = StringIO.new("hello\n")
    console = described_class.new(input, nil)
		
    expect(console.read()).to eq("hello\n")
  end

end