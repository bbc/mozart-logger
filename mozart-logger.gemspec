lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mozart/logger/version"

Gem::Specification.new do |spec|
  spec.name          = "mozart-logger"
  spec.version       = Mozart::Logger::VERSION
  spec.authors       = ["BBC News"]
  spec.email         = ["FutureMediaNewsRubyGems@bbc.co.uk"]

  spec.summary       = "Mozart Logging and Metrics"
  spec.description   = "Private gem setting up logging/metrics for Mozart"
  spec.homepage      = "https://github.com/bbc/mozart-logger"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
                          f.match(%r{^(test|spec|features)/})
                        end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "alephant-logger", "~> 3"
  spec.add_runtime_dependency "alephant-logger-cloudwatch", "~> 2"
  spec.add_runtime_dependency "alephant-logger-json", "~> 0"
  spec.add_runtime_dependency "bbc-cosmos-config"
end
