class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :target_url, index: { unique: true }
      t.string :slug, index: { unique: true }

      t.timestamps null: false
    end
  end
end
