class CreateSearchInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :search_instances do |t|
      t.integer :search_id
      t.string :result

      t.timestamps
    end
    add_foreign_key :search_instances, :searches
  end
end
