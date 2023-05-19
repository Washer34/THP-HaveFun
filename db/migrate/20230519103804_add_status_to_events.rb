class AddStatusToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :status, :integer, null: false, default: 0
  end
end
