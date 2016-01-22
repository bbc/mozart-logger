require "pry"
require "mozart/logger"

describe Mozart::Logger do
  let(:opts)     {{ :statsd => {} }}
  let(:log_path) { "app.log" }

  describe ".setup" do
    specify do
      expect(subject.setup opts, log_path).to be_a Alephant::Logger::Base
    end
  end
end
