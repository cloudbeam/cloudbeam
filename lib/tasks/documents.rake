require 'task_helpers/documents_helper'
include RakeDocumentsHelper

namespace :demo do
  desc "Find all documents for demo account and purge"
  task remove_demo_docs: "environment" do
    demo_id = User.where(email: 'demo@cloud-beam.com').first.id
    demo_docs = Document.where(user_id: demo_id)
    demo_docs.each do |doc|
      doc.upload.purge unless Rails.env.test?
      doc.destroy
    end
  end
end

namespace :expired do
  desc "Check for docs uploaded over 30 days ago and remove"
  task remove_old: "environment" do
    one_month_ago = DateTime.now.days_ago(30)
    old_docs = Document.where(['uploaded_at < :expired_date', {expired_date: one_month_ago}])
    old_docs.each do |doc|

      email = User.where(id: doc.user_id).first.email
      recipients = DocumentRecipient.where(document_id: doc.id).to_a
      recipients_not_dl = []
      recipients_downloaded = []

      recipients.each do |recipient|
        if !recipient[:expired_at]
          recipients_not_dl.push recipient
        else
          recipients_downloaded.push recipient
        end
      end

      DocumentMailer.cleaned(email, doc, recipients_not_dl, recipients_downloaded).deliver_later

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

  desc "call cleaned" 
  task cleaned: "environment" do
    doc = Document.where("id IS NOT NULL").first
    DocumentMailer.cleaned('kaledoux@gmail.com', doc, [{email: "kaledoux@gmail.com"}],[{email: "kaledoux@gmail.com"}]).deliver_now
  end
end