require "mozart/logger/version"
require "alephant/logger"
require "alephant/logger/json"
require "alephant/logger/statsd"
require "alephant/logger/cloudwatch"
require "bbc/cosmos/config"

module Mozart
  module Logger
    def self.setup(opts, log_path)
      Alephant::Logger.setup drivers(opts, log_path)
    end

    def self.drivers(opts, log_path)
      [].tap do |drivers|
        drivers << json_driver(log_path)
        drivers << metric_driver(opts)
      end
    end

    def self.metric_driver(opts)
      return statsd_driver(opts[:statsd])  if opts[:statsd]
      cloudwatch_driver(opts[:cloudwatch]) if opts[:cloudwatch] && production?
    end

    def self.json_driver(log_path)
      Alephant::Logger::JSON.new log_path
    end

    def self.statsd_driver(opts)
      Alephant::Logger::Statsd.new opts
    end

    def self.cloudwatch_driver(opts)
      Alephant::Logger::CloudWatch.new cloudwatch_namespace(opts)
    end

    def self.cloudwatch_namespace(opts)
      opts.tap do |h|
        h[:namespace] = h[:namespace] % BBC::Cosmos::Config.cosmos.environment
      end
    end

    def self.production?
      BBC::Cosmos::Config.cosmos.environment == "live"
    end
  end
end
