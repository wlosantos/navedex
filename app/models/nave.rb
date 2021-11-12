class Nave < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy

  validates :name, :birthdate, :admision_job, :job_role, :user_id, presence: true

  def self.list_naves
    list = self.all.map do |nave|
      {
        id: nave.id,
        name: nave.name,
        birthdate: nave.birthdate.strftime("%Y-%m-%d"),
        admision_job: nave.admision_job.strftime("%Y-%m-%d"),
        job_role: nave.job_role
      }
    end
  end

  def description_nave
    nave = {
      id: self.id,
      name: self.name,
      birthdate: self.birthdate.strftime("%Y-%m-%d"),
      admision_job: self.admision_job.strftime("%Y-%m-%d"),
      job_role: self.job_role,
      projects: self.projects.map{ |proj| {id: proj.id, name: proj.name} }
    }
  end

  def store_nave
    nave = {
      id: self.id,
      name: self.name,
      birthdate: self.birthdate.strftime("%Y-%m-%d"),
      admision_job: self.admision_job.strftime("%Y-%m-%d"),
      job_role: self.job_role,
      projects: self.projects.map(&:name).count
    }
  end
end
