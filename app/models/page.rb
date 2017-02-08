class Page < ApplicationRecord
  has_many :run
  belongs_to :site
end
