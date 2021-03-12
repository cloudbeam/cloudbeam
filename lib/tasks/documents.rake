namespace :expired do
  desc "Check for docs with expired at values and remove"
  task remove_expired: "environment"do
    expired_docs = Document.where(["expired_at < :current", {current: DateTime.now}])
    expired_docs.each do |doc|
      if Rails.env.test?
        doc.destroy
        puts doc.destroyed?
      else
        doc.upload.purge
        doc.destroy
      end
    end
  end

  desc "Find and display all docs with expired at values"
  task show_expired: "environment" do
    docs = Document.where(["expired_at < :current", {current: DateTime.now}])
    puts "Total number of expired docs: #{docs.size}"
    docs.each do |doc|
      puts '~~~~> ' + doc.name
    end
    puts docs.size
  end
end