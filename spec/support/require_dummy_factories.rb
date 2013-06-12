# Add dummy/spec/factories to definition_file_paths
FactoryGirl.definition_file_paths = [File.join(File.dirname(__FILE__), "../dummy_#{RAILS_MINOR_VERSION}/spec/factories")]
