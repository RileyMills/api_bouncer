class ApiBouncer

  mattr_accessor :comparator_constraint
  @@comparator_constraint = '~>'

  mattr_accessor :current_app_version
  @@current_app_version = '0.2.0'

  mattr_accessor :minimum_app_version
  @@minimum_app_version = '0.1.5'

  mattr_accessor :app_deprecated_version_warning_message
  @@app_deprecated_version_warning_message = "Your application is out of date.  Please update soon."

  mattr_accessor :app_old_version_error_message
  @@app_old_version_error_message = "Your application is out of date.  You must update to continue using the application."

  mattr_accessor :app_new_version_error_message
  @@app_new_version_error_message = "Your application is too new.  Please come back later."

  mattr_accessor :app_no_version_error_message
  @@app_no_version_error_message = "Your application is not sending a version header."

  mattr_accessor :app_version_header_key
  @@app_version_header_key = "HTTP_X_APP_VERSION"



  module Controllers
    autoload :ApiBouncerMethods, 'api_bouncer/controllers/api_bouncer_methods'
  end

  module Exceptions
    class ApiBouncer::OldAppVersionError < StandardError
    end

    class ApiBouncer::NewAppVersionError < StandardError
    end

    class ApiBouncer::DeprecatedAppVersionError < StandardError
    end

    class ApiBouncer::NoAppVersionError < StandardError
    end

    class ApiBouncer::PanicError < StandardError
    end
  end

  class ApiBouncerRailtie < Rails::Railtie
    initializer "api_bouncer_railtie.extend_action_controller" do
      ActiveSupport.on_load :action_controller do
        # At this point, self == ActionController::Base
        include ApiBouncer::Controllers::ApiBouncerMethods
      end
    end
  end

  def self.setup
    yield self
  end

  def self.app_version_header_key=(val)
    @@app_version_header_key = "HTTP_#{val.strip.upcase.tr('-', '_')}"
  end

  def self.comparator_constraint=(val)
    @@comparator_constraint = val.strip
  end

  def self.current?(version)
    Gem::Dependency.new('', "#{self.comparator_constraint} #{self.current_app_version}").match?('', version)
  end

  def self.allowable?(version)
    Gem::Version.new(version) > Gem::Version.new(self.minimum_app_version) && Gem::Version.new(version) <= Gem::Version.new(self.current_app_version)
  end

  def self.ahead?(version)
    Gem::Version.new(version) > Gem::Version.new(self.current_app_version)
  end

  def self.behind?(version)
    Gem::Version.new(version) < Gem::Version.new(self.minimum_app_version)
  end

  def self.validate(version)

    if version.blank?
      raise ApiBouncer::NoAppVersionError, app_no_version_error_message
    elsif current?(version)
      return true
    elsif allowable?(version)
      raise ApiBouncer::DeprecatedAppVersionError, app_deprecated_version_warning_message
    elsif behind?(version)
      raise ApiBouncer::OldAppVersionError, app_old_version_error_message
    elsif ahead?(version)
      raise ApiBouncer::NewAppVersionError, app_new_version_error_message
    else
      raise ApiBouncer::PanicError
    end

  end

end