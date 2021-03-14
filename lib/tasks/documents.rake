namespace :expired do
  desc "Check for docs with expired at values and remove"
  task remove_expired: "environment" do
    one_month_ago = DateTime.now.days_ago(30)
    expired_docs = Document.where(['uploaded_at < :expired_date', {expired_date: one_month_ago}])
    expired_docs.each do |doc|
      if Rails.env.test?
        doc.destroy
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