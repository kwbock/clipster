class CreateClipsterClips < ActiveRecord::Migration
  def change
    create_table :clipster_clips, :id => false do |t|
      t.string :id, :options => 'PRIMARY KEY'
      t.text :clip, :null => false
      t.string :language, :null => false
      t.string :title, :null => false
      t.boolean :private, :null => false
      t.timestamps
    end
  end
end
