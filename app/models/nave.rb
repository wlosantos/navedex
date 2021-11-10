class Nave < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy

  validates :name, :birthdate, :admision_job, :job_role, :user_id, presence: true
end
