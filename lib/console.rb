class Console 

  def initialize(input, output)
    @input  = input
    @output = output
  end

  def print(message)
    output.puts(message)
  end

  def read 
    input.gets()
  end

  private

  attr_reader :input, :output

end