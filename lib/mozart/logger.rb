require "mozart/logger/version"
require "alephant/logger"
require "alephant/logger/cloudwatch"
require "alephant/logger/json"
require "bbc/cosmos/config"

module Mozart
  module Logger
    def self.setup(cloudwatch_opts, log_path)
      Alephant::Logger.setup drivers(cloudwatch_opts, log_path)
    end

    def self.drivers(cloudwatch_opts, log_path)
      [].tap do |drivers|
        drivers << json_driver(log_path)
        drivers << cloudwatch_driver(cloudwatch_opts) if production?
      end
    end

    def self.json_driver(log_path)
      Alephant::Logger::JSON.new log_path
    end

    def self.cloudwatch_driver(cloudwatch_opts)
      Alephant::Logger::CloudWatch.new cloudwatch_namespace(cloudwatch_opts)
    end

    def self.cloudwatch_namespace(cloudwatch_opts)
      cloudwatch_opts.tap do |h|
        h[:namespace] = h[:namespace] % BBC::Cosmos::Config.cosmos.environment
      end
    end

    def self.production?
      BBC::Cosmos::Config.cosmos.environment == "live"
    end
  end
end
