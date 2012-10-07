class SetDefaultTitleToUntitled < ActiveRecord::Migration
  def up
    change_column_default :clipster_clips, :title, 'Untitled'
  end

  def down
    change_column_default :clipster_clips, :title, ''
  end
end
