class Project < ApplicationRecord

  belongs_to :nave

  validates_presence_of :name, :nave_id
end
