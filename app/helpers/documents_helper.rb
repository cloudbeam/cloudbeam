module DocumentsHelper

  def create_new_document_recipient(recipient, doc_id, download_code)
    DocumentRecipient.create!({
      document_id: doc_id,
      shared_at: Time.now,
      download_code: download_code,
      email: recipient.strip
    })
  end

  def created_at_local_time(doc)
    doc.created_at.localtime.to_formatted_s(:long)
  end
end
