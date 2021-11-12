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

  def project_with_nave
    list = {}
    if self.id.present?
      list = {
        id: self.id,
        name: self.name,
        nave: {
          id: self.nave.id,
          name: self.nave.name,
          birthdate: self.nave.birthdate,
          admision_job: self.nave.admision_job,
          job_role: self.nave.job_role
        }
      }
    end
  end
end
