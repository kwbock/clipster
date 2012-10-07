class PopulateClipDefaults < ActiveRecord::Migration
  def up
    change_table :clipster_clips do |t|
      t.change_default :hash, ''
      t.change_default :clip, ''
      t.change_default :title, ''
      t.change_default :language, ''
      t.change_default :private, false
    end
  end

  def down
    change_table :clipster_clips do |t|
      t.change_default :hash, nil
      t.change_default :clip, nil
      t.change_default :title, nil
      t.change_default :language, nil
      t.change_default :private, false
    end
  end
end
