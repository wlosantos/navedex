FactoryBot.define do
  factory :nave do
    name { Faker::Name.name }
    birthdate { Faker::Date.between(from: '1970-09-23', to: '2021-09-25') }
    admision_job { Faker::Date.between(from: '2021-01-01', to: '2021-09-25') }
    job_role { Faker::Job.field }
    user
  end
end
