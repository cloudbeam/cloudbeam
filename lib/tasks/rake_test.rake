namespace :cron_test do
  desc "output total number of documents" 
  task document_count: "environment" do
    docs = Document.all
    puts DateTime.now
    puts "There are currently #{docs.size} documents in the system"
    "#{DateTime.now} : #{docs.size} documents in database"
  end
end