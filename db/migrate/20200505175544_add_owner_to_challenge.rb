class AddOwnerToChallenge < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :owner_id, :integer
  end
end
