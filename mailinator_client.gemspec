$LOAD_PATH.push(File.expand_path("../lib", __FILE__))
require "mailinator_client/version"

Gem::Specification.new do |gem|
  gem.name          = "mailinator_client"
  gem.authors       = ["Marian Melnychuk"]
  gem.email         = ["marian.melnychuk@gmail.com"]
  gem.summary       = %q{Provides a simple ruby wrapper around the Mailinator REST API}
  gem.description   = %q{Easily use the Mailinator through its REST API with Ruby}
  gem.homepage      = "https://github.com/manybrain/mailinator-ruby-client"
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.version       = MailinatorClient::VERSION
  gem.licenses      = ["MIT"]

  gem.required_ruby_version = ">= 2.1"

  gem.add_dependency "httparty", "~> 0.21.0"

  gem.add_development_dependency "minitest", "~> 5.9"
  gem.add_development_dependency "rake", "~> 12"
  gem.add_development_dependency "webmock", "~> 2.3"
end
