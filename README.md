![Status](https://github.com/kaledoux/cloudbeam/actions/workflows/verify.yml/badge.svg)

# Cloudbeam
Using Rails 6 and Ruby 2.6.6


### To run locally
-  `yarn install`
-  `bundle install`
-  `bin/rails s`

#### Rake Tasks
**Development database spot checking:**
- `rake current_data:total_report`
- `rake current_data:report_users`
- `rake current_data:report_documents`
- `rake current_data:report_document_recipients`
- `rake current_data:report_attachments`
- `rake current_data:report_blobs`

### Testing
- `bin/rails t`
