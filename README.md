![Status](https://github.com/kaledoux/cloudbeam/actions/workflows/verify.yml/badge.svg)

# Cloudbeam  :cloud:
:hammer: Built with
- [Rails 6](https://guides.rubyonrails.org/) and Ruby 2.6.6
- [Heroku](https://www.heroku.com/)
- [AWS S3](https://aws.amazon.com/s3) storage
- [AWS Cloudfront](https://aws.amazon.com/cloudfront/) distribution
- [PostgreSQL](https://www.postgresql.org/)
- [Mailgun](https://www.mailgun.com/)

## Visit on the web :earth_americas:
[cloud-beam.com](https://www.cloud-beam.com)

## Try it out using our demo credentials :key:
- user: demo@cloud-beam.com
- password: 'Testing Our App 123#'

## Authors
- [Kyle LeDoux](https://github.com/kaledoux) - kaledoux@gmail.com
- [Jimmy Zheng](https://github.com/jimzhe842) - jimmy_842@berkeley.edu
- [Elizabeth Tackett](http://github.com/emctackett) - emctackett@gmail.com

---

## Development notes :computer:

### To run the app locally
-  `yarn install`
-  `bundle install`
-  `bin/rails s`

### Rake Tasks

**Development database spot checking:**
- `rake current_data:total_report`
- `rake current_data:report_users`
- `rake current_data:report_documents`
- `rake current_data:report_document_recipients`
- `rake current_data:report_attachments`
- `rake current_data:report_blobs`

### Testing locally
- `bin/rails t`

### Heroku from the command line (must be a collaborator):
`heroku pg:psql`
