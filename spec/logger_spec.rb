require 'pry'
require 'mozart/logger'
require 'bbc/cosmos/config'

describe Mozart::Logger do
  let(:opts)     do
    {
      statsd:     {},
      cloudwatch: {}
    }
  end

  let(:cloudwatch) do
    {
      cloudwatch: {
        namespace: 'BBCApp/mozart-foo/%s'
      }
    }
  end

  let(:log_path) { 'app.log' }

  def enable_live
    allow(BBC::Cosmos::Config.cosmos)
      .to receive(:environment).and_return('live')
  end

  describe '.setup' do
    specify do
      expect(subject.setup(opts, log_path)).to be_a Alephant::Logger::Base
    end
  end

  describe '.drivers' do
    context 'Statsd and Cloudwatch provided' do
      specify do
        enable_live
        expect(subject.drivers(opts, log_path).length).to eq(2)
      end

      specify do
        enable_live
        first_driver = subject.drivers(opts, log_path)[0]
        expect(first_driver).to be_a Alephant::Logger::JSON
      end

      specify do
        enable_live
        second_driver = subject.drivers(opts, log_path)[1]
        expect(second_driver).to be_a Alephant::Logger::Statsd
      end
    end

    context 'Only Cloudwatch provided' do
      specify do
        expect(subject.drivers(cloudwatch, log_path).length).to eq(2)
      end

      specify do
        enable_live
        first_driver = subject.drivers(cloudwatch, log_path)[0]
        expect(first_driver).to be_a Alephant::Logger::JSON
      end

      specify do
        enable_live
        second_driver = subject.drivers(cloudwatch, log_path)[1]
        expect(second_driver).to be_a Alephant::Logger::CloudWatch
      end
    end
  end
end
