class AddUserIdToClips < ActiveRecord::Migration
  def up
    add_column :clipster_clips, :user_id, :integer
  end

  def down
    remove_column :clipster_clips, :user_id
  end
end
