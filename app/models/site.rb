class Site < ApplicationRecord
  has_many :pages
  belongs_to :user
end
