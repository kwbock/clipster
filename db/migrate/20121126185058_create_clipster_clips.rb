class CreateClipsterClips < ActiveRecord::Migration
  def up
    create_table :clipster_clips, :id => false, :primary_key => :id do |t|
      t.string :id, :null => false, :unique => true
      t.text :clip, :null => false
      t.string :language, :null => false, :default => 'text'
      t.string :title, :null => false, :default => 'Untitled'
      t.boolean :private, :null => false, :default => false
      t.integer :user_id
      t.datetime :expires
      t.timestamps
    end
  end

  def down
    drop_table :clipster_clips
  end
end
