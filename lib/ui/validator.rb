# frozen_string_literal: true

class Validator
  def valid_index?(count, input)
    valid_indexes(count).include? input
  end

  def valid_field?(field, input)
    field_validation_rules(field, input)
  end

  private

  def valid_indexes(count)
    inputs = []
    (1..count).each { |i| inputs << i.to_s }
    inputs
  end

  def field_validation_rules(field, input)
    {
      'phone' => phone_valid?(input),
      'email' => email_valid?(input)
    }.fetch(field, true)
  end

  def phone_valid?(input)
    input.size == 11 && (input =~ /[0-9]/).zero?
  end

  def email_valid?(input)
    input.include?('@')
  end
end
