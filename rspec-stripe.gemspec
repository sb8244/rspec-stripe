Gem::Specification.new do |s|
  s.name               = "rspec-stripe"
  s.license = "MIT"
  s.date = %q{2014-09-26}
  s.authors = ["Stephen Bussey"]
  s.email = %q{steve.bussey@salesloft.com}
  s.homepage = %q{https://github.com/sb8244/rspec-stripe}

  s.summary = %q{Setup Stripe for specs easily and reliably}
  s.description = %q{Setup the Stripe World for your rspec tests}

  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")

  s.version            = "0.0.8"
  s.required_ruby_version = '>= 2.0.0'
  s.required_rubygems_version = '>= 1.6.2'

  s.add_runtime_dependency "stripe"
  s.add_runtime_dependency "rspec"

  s.add_development_dependency "dotenv"
  s.add_development_dependency "fakeweb"
end
