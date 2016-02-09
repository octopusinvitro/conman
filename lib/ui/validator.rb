class Validator

  def valid_option?(menu, option)
    valid_options(menu).include? option
  end

  def valid_options(menu)
    options = []
    (1..menu.size).each { |i| options << i.to_s }
    options
  end

end