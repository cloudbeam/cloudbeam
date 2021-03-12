module DocumentRecipientsHelper
  def shared_at_local_time(recipient)
    recipient.shared_at.localtime.to_formatted_s(:long)
  end

  def did_recipient_use_download_code(recipient)
    recipient.downloaded_at.nil? ? 'No' : 'Yes'
  end

  def create_download_again_link(recipient)
    return unless recipient.downloaded_at.nil?

    button_tag 'Send Again',
               type: 'button',
               class: 'send-again-btn text-blue-400 background-transparent font-normal text-sm outline-none focus:outline-none',
               data: {recipient: recipient.email, recipient_id: recipient.id, document_id: recipient.document_id}
  end
end
