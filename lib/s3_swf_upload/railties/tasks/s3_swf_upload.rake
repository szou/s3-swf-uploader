require 'aws/s3'

namespace :s3_swf_upload do
  desc "create a bucket according to your setting in config/amazon_s3.yml"
  task :make_bucket => :environment do
    connect_s3!
    AWS::S3::Bucket.create(S3SwfUpload::S3Config.bucket)
  end

  desc "put a standard crossdomain.xml into your bucket"
  task :make_crossdomain => :environment do
    connect_s3!
    file = File.expand_path(File.join(File.dirname(__FILE__), 'crossdomain.xml'))
    AWS::S3::S3Object.store('crossdomain.xml', open(file), S3SwfUpload::S3Config.bucket, :access => :public_read)
  end

  def connect_s3!
    AWS::S3::Base.establish_connection!(
      :access_key_id => S3SwfUpload::S3Config.access_key_id,
      :secret_access_key => S3SwfUpload::S3Config.secret_access_key
    )
  end
end