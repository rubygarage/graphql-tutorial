class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
