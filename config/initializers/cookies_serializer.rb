# Be sure to restart your server when you modify this file.

Rails.application.config.action_dispatch.cookies_serializer = :json

# See the comment of TomK32 https://github.com/mongoid/mongoid/issues/3702
class BSON::ObjectId
  def as_json(*args)
    self.to_s
  end
end