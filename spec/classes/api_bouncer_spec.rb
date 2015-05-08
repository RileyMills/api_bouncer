describe "ApiBouncer Tests" do

  it "injects itself into ActionController::Base" do
    ActionController::Base.new.should respond_to?(:validate_app_version)
  end

  context "Configuration" do

    it "can be configured" do
      ApiBouncer.setup do |config|
        config.comparator_constraint = '='
        config.current_app_version = '1.2.3'
        config.minimum_app_version = '0.1.2'
        config.app_version_header_key = "x-my-great-header"
        config.app_deprecated_version_warning_message = "Foo"
        config.app_old_version_error_message = "Bar"
        config.app_new_version_error_message = "Baz"
        config.app_no_version_error_message = "Qux"
      end

      ApiBouncer.comparator_constraint.should eql('=')
      ApiBouncer.current_app_version.should eql('1.2.3')
      ApiBouncer.minimum_app_version.should eql('0.1.2')
      ApiBouncer.app_version_header_key.should eql("HTTP_X_MY_GREAT_HEADER")
      ApiBouncer.app_deprecated_version_warning_message.should eql("Foo")
      ApiBouncer.app_old_version_error_message.should eql("Bar")
      ApiBouncer.app_new_version_error_message.should eql("Baz")
      ApiBouncer.app_no_version_error_message.should eql("Qux")

    end

  end

  context "Logic and Parsing" do

  end

end