namespace :current_data do
  desc "Report current db entity totals"
  task total_report: "environment" do
    users = User.where("id IS NOT NULL").count
    docs = Document.where("id IS NOT NULL").count
    doc_recs = DocumentRecipient.where("id IS NOT NULL").count
    attachments = ActiveRecord::Base.connection.execute("select * from active_storage_attachments").count
    blobs = ActiveRecord::Base.connection.execute("select * from active_storage_blobs").count

    report = "Users: #{users} | Docs: #{docs} | Recipients: #{doc_recs} |" + 
             "Attachments: #{attachments} | Blobs: #{blobs}"
    puts report
  end

  desc "List current users"
  task report_users: "environment" do
    users = User.where("id IS NOT NULL").find_each(batch_size: 25) do |user|
      puts "Name: #{user.first_name} #{user.last_name} |" + 
           " Email: #{user.email}"
    end
  end

  desc "List current documents"
  task report_documents: "environment" do
    Document.where("id IS NOT NULL").each do |doc|
      puts "ID: #{doc.id} | Name: #{doc.name} | Uploaded At: #{doc.uploaded_at} |" + 
           " Expired At: #{doc.expired_at} | User ID: #{doc.user_id}"
    end
  end

  desc "List current document recipients"
  task report_document_recipients: "environment" do
    DocumentRecipient.where("id IS NOT NULL").each do |rec|
      puts "ID: #{rec.id} | Code: #{rec.download_code} | Email: #{rec.email} |" +
      " Shared At: #{rec.shared_at} | Downloaded At: #{rec.downloaded_at} |" +
      " Document ID: #{rec.document_id}"
    end
  end

  desc "List current document attachments"
  task report_attachments: "environment" do
    ActiveRecord::Base.connection.exec_query("select * from active_storage_attachments").each do |att|
      puts "ID: #{att['id']} | Created At: #{att['created_at']} |" +
      " Document ID: #{att['record_id']} | Blob ID: #{att['blob_id']}" 
    end
  end

  desc "List current attachment blobs"
  task report_blobs: "environment" do
    ActiveRecord::Base.connection.execute("select * from active_storage_blobs").each do |blob|
      puts "ID: #{blob["id"]} | Filename: #{blob["filename"]} | Key: #{blob["key"]} |"
    end
  end
end