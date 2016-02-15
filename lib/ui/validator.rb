class Validator

  def valid_index?(size, input)
    valid_indexes(size).include? input
  end

  def valid_field?(field, input)
    field_validation_rules(field, input)
  end

  private

  def valid_indexes(size)
    inputs = []
    (1..size).each { |i| inputs << i.to_s }
    inputs
  end

  def field_validation_rules(field, input)
    {
      "phone"   => is_phone_valid?(input),
      "email"   => is_email_valid?(input)
    }.fetch(field, true)
  end

  def is_phone_valid?(input)
    input.size == 11 && /[0-9]/ === input
  end

  def is_email_valid?(input)
    input.include?("@")
  end

end