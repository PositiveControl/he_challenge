class SearchInstance < ApplicationRecord
  belongs_to :search
  validates_presence_of :search_id, :result
end
