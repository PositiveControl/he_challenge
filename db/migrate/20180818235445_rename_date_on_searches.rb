class RenameDateOnSearches < ActiveRecord::Migration[5.2]
  def change
    change_column :searches, :date, :datetime
    rename_column :searches, :date, :last_searched
    remove_column :searches, :result
    remove_column :searches, :times_searched
    add_index :searches, :term
  end
end
