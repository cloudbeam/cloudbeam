module RakeDocumentsHelper
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