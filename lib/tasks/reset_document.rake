namespace :document do
  desc "reset document expiration and download data, takes in document id as an argument"
  task :reset, [:id] => [:environment] do |t, args|
    Document.find(args[:id]).update(expired_at: nil)
    DocumentRecipient.where(document_id: args[:id]).each do |recipient|
      recipient.update(downloaded_at: nil)
    end
    puts "Reset document for document: #{args[:id]}"
  end
end