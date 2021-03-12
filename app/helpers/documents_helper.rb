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


  def get_document_download_stats(doc)
    recipients = DocumentRecipient.where(document_id: doc.id)
    times_shared = recipients.size
    times_downloaded = 0
    recipients.each do |recipient|
      if recipient.downloaded_at != nil then
        times_downloaded += 1
      end
    end
    {times_shared: times_shared, times_downloaded: times_downloaded}
  end
end
