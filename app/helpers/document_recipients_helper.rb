module DocumentRecipientsHelper
  def shared_at_local_time(recipient)
    recipient.shared_at.localtime.to_formatted_s(:long)
  end

  def create_download_again_link(recipient)
    "<%= #{recipient.downloaded_at} == nil ? 'No' : 'Yes' %>
    <br>
      <button class='text-blue-400 background-transparent font-normal text-sm outline-none focus:outline-none' 
        type='button' 
        style='transition: all .15s ease'>
          send again
      </button>"
  end
end
