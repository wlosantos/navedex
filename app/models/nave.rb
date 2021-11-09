class Nave < ApplicationRecord
  belongs_to :user

  validates :name, :birthdate, :admision_job, :job_role, :user_id, presence: true
end
