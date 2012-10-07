class RemoveDefaultFromLanguage < ActiveRecord::Migration
  def up
    change_column_default :clipster_clips, :language, nil
  end

  def down
    change_column_default :clipster_clips, :language, ''
  end
end
