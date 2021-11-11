class Project < ApplicationRecord

  belongs_to :nave

  validates_presence_of :name, :nave_id

  def self.total_user_projects(user)
    list = self.joins(:nave).where(nave: { user: user })
    result = list.map do |project|
      {
        id: project.id,
        name: project.name
      }
    end
  end
end
