class CreateNaves < ActiveRecord::Migration[6.1]
  def change
    create_table :naves do |t|
      t.string :name, null: false
      t.datetime :birthdate, null: false
      t.datetime :admision_job, null: false
      t.string :job_role, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
