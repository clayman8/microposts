class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
      
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end