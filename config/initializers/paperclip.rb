module Paperclip
  class Attachment
    class << self
      alias_method :origin_default_options, :default_options
      def default_options
        options = origin_default_options.deep_merge({
          default_url: '/defaults/:attachment/:style.png'
        })
        if configatron.aws.enabled?
          options.deep_merge!({
            storage:      :s3,
            url:          ":s3_alias_url",
            path:         "#{Rails.env.first}/:class/:attachment/:id_partition/:style/:filename",
            bucket:       configatron.aws.bucket,
            s3_credentials: {
              access_key_id: configatron.aws.access_key,
              secret_access_key: configatron.aws.secret_key,
            },
            s3_protocol: 'http',
            s3_host_alias: configatron.aws.cloudfront_host
          })
        end
        options
      end
    end
  end
end