class PopularMigration < ActiveRecord::Migration
  def up
    create_table :friendships do |t|

      t.references :popular_model, polymorphic: true
      t.references :friend, polymorphic: true

      t.timestamps
    end

    add_index :friendships, [:popular_model_id, :popular_model_type]
    add_index :friendships, [:friend_id, :friend_type]
  end

  def down
    drop_table :friendships
  end
end
