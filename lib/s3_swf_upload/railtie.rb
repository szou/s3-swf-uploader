require 's3_swf_upload'
require 'rails'

module S3SwfUpload
  class Railtie < Rails::Railtie
    
    initializer "s3_swf_upload.load_s3_swf_upload_config" do
      S3SwfUpload::S3Config.load_config
    end
    
    rake_tasks do
      load "s3_swf_upload/railties/tasks/s3_swf_upload.rake"
    end
    
    generators do
      require "s3_swf_upload/railties/generators/uploader/uploader_generator"
    end
    
  end
end
