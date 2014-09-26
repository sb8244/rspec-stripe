Gem::Specification.new do |s|
  s.name               = "rspec-stripe"
  s.version            = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Bussey"]
  s.date = %q{2014-9-26}
  s.description = %q{Setup the Stripe World for your rspec tests}
  s.email = %q{steve.bussey@salesloft.com}
  s.files = ["lib/rspec-stripe.rb"]
  s.homepage = %q{http://rubygems.org/gems/rspec-stripe}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Setup Stripe for specs easily and reliably}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
