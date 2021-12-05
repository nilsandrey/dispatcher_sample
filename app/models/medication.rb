class Medication < ApplicationRecord
  # Name field validations
  validates :name, presence: true
  validates :name, uniqueness: true
  validates_format_of :name, with: /\A[a-zA-Z0-9\-_ ]+\z/

  # Code field validations
  validates :code, presence: true
  validates :code, uniqueness: true
  validates_format_of :code, with: /\A[A-Z0-9_]+\z/

end
