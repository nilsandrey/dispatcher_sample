class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def abort_with_error(field, message)
    errors.add(field, message)
    throw :abort
  end

  def throw_error(message)
    throw StandardError.new(message)
  end
end
