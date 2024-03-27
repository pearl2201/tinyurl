class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :originUrl
      t.string :shortPath

      t.timestamps
    end
    add_index :urls, :shortPath
  end
end
