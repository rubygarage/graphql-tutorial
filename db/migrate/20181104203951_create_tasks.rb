class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :done, default: false
      t.references :project, foreign_key: true
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
