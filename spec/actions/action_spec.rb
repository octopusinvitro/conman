require 'actions/action'

describe Action do

  let(:ui)     {instance_double(UI).as_null_object}
  let(:action) {described_class.new(ui)}

  it "clears the screen as the first thing" do
    action.run
    expect(ui).to have_received(:clear).once
  end

end