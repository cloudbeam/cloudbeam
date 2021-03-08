class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.datetime :uploaded_at
      t.datetime :expired_at
      t.string :url
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
