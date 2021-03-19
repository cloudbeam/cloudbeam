namespace :expired do
  desc "Check for docs uploaded over 30 days ago and remove"
  task remove_old: "environment" do
    one_month_ago = DateTime.now.days_ago(30)
    old_docs = Document.where(['uploaded_at < :expired_date', {expired_date: one_month_ago}])
    puts old_docs.size
    old_docs.each do |doc|
      if Rails.env.test?
        doc.destroy
      else
        doc.upload.purge
        doc.destroy
      end
    end
  end

  desc "Check for docs with expired_at dates and remove"
  task remove_expired: "environment" do
    expired_docs = Document.where('expired_at IS NOT NULL')
    puts expired_docs.size
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
    docs.size
  end
  
  desc "Find and display all docs over 30 days old"
  task show_old: "environment" do
    docs = Document.where(["uploaded_at < :expire_date", {expire_date: DateTime.now.days_ago(30)}])
    puts "Total number of old docs: #{docs.size}"
    docs.each do |doc|
      puts '~~~~> ' + doc.name
    end
    docs.size
  end
end