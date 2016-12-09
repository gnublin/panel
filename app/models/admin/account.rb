class Admin::Account < ApplicationRecord
  has_many :user
end
