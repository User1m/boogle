class CreatePageContents < ActiveRecord::Migration[5.0]
  def change
    create_table :page_contents do |t|
      t.integer :page_id
      t.timestamps
    end
  end
end
