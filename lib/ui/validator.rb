class Validator

  def valid_index?(size, input)
    valid_indexes(size).include? input
  end

  private

  def valid_indexes(size)
    inputs = []
    (1..size).each { |i| inputs << i.to_s }
    inputs
  end

end