class CreateDocumentRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :document_recipients do |t|
      t.string :download_code
      t.datetime :downloaded_at
      t.datetime :shared_at
      t.belongs_to :document, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
