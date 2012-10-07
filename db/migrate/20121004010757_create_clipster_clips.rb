class CreateClipsterClips < ActiveRecord::Migration
  def up
    create_table :clipster_clips do |t|
      t.string :hash, :options, :null => false
      t.text :clip, :null => false
      t.string :language, :null => false
      t.string :title, :null => false
      t.boolean :private, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :clipster_clips
  end
end
