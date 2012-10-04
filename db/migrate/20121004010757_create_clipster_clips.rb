class CreateClipsterClips < ActiveRecord::Migration
  def change
    create_table :clipster_clips do |t|
      t.string :id
      t.text :clip
      t.string :language

      t.timestamps
    end
  end
end
