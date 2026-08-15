$LOAD_PATH.push(File.expand_path("../lib", __FILE__))
require "mailinator_client/version"

Gem::Specification.new do |gem|
  gem.name          = "mailinator_client"
  gem.authors       = ["Manybrain, LLC"]
  gem.email         = ["support@manybrain.com"]
  gem.summary       = %q{Provides a simple ruby wrapper around the Mailinator REST API}
  gem.description   = %q{Easily use the Mailinator through its REST API with Ruby}
  gem.homepage      = "https://github.com/manybrain/mailinator-ruby-client"
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.version       = MailinatorClient::VERSION
  gem.licenses      = ["MIT"]

  gem.required_ruby_version = ">= 2.7"

  gem.add_dependency "httparty", ">= 0.24", "< 0.25"

  gem.add_development_dependency "addressable", ">= 2.9", "< 3.0"
  gem.add_development_dependency "minitest", ">= 5.26", "< 6.0"
  gem.add_development_dependency "rake", ">= 13.4", "< 14.0"
  gem.add_development_dependency "webmock", ">= 3.26.2", "< 4.0"
end
