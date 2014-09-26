module RSpecStripe
  class Configuration
    def configure_rspec_metadata!
      unless @rspec_metadata_configured
        RSpecStripe::RSpec::Metadata.configure!
        @rspec_metadata_configured = true
      end
    end
  end
end
