module ApiBouncer::Controllers::ApiBouncerMethods
  extend ActiveSupport::Concern

  def validate_app_version
    header_value = request.headers["#{ApiBouncer.app_version_header_key}"]
    ApiBouncer.validate(header_value)
  end

end
