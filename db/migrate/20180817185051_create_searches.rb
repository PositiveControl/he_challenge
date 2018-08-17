class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :term
      t.date :date
      t.integer :times_searched
      t.string :result

      t.timestamps
    end
  end
end
