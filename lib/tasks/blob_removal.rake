namespace :unattached do
  desc "Report name and key of all unattached blobs"
  task show_unattached_blobs: "environment" do 
    puts "The following blobs and s3 objects are unattached:"
    ActiveStorage::Blob.unattached.each do |blob|
      puts "File Name: #{blob.filename} | Object Name: #{blob.key}"
    end
  end

  desc "Find and remove all unattached blobs and associated S3 objects"
  task remove_unattached_blobs: :environment do
    ActiveStorage::Blob.unattached.each(&:purge)
  end
end
