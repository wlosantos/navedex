class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :nave, null: false, foreign_key: true

      t.timestamps
    end
  end
end
