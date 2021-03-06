# Mozart::Logger

Internal gem for setting up structured logging and metrics for use within our Mozart service applications.

It is an abstraction wrapping around our open-source software [Alephant Logger](https://github.com/BBC-News/alephant-logger).

## Installation

Add this line to your application's Gemfile:

```ruby
group :production do
  gem "mozart-logger", "1.0.0", :git => "git@github.com:bbc/mozart-logger.git"
end
```

And then execute:

    $ bundle install

## Setup

```rb
require "mozart/logger"

opts = {
  :statsd => {
    :host      => ENV["STATSD_HOST"],
    :port      => 8125,
    :namespace => "mozart-routing"
  },
  :cloudwatch => {
    :namespace => ENV["CLOUDWATCH_NAMESPACE"]
  }
}

Mozart::Logger.setup opts, ENV["APP_LOG_LOCATION"] # configures Alephant Logger

use Rack::CommonLogger, Alephant::Logger.get_logger # optional
```

> Note: you should only provide one key  
> either `:statsd` or `:cloudwatch`  
> the latter will be ignored if both provided

## Usage

```rb
require "alephant/logger"

class Foo
  include include Alephant::Logger

  def initialize
    logger.info(
      "event"   => "ClassInitialized",
      "method"  => "#{self.class.name}##{__method__}",
      "someKey" => 123
    )
  end
end
```

> Note: for more details, refer to the following gems  
> [Alephant-Logger-CloudWatch](https://github.com/BBC-News/alephant-logger-cloudwatch), [Alephant-Logger-Statsd](https://github.com/BBC-News/alephant-logger-statsd/) and [Alephant-Logger-JSON](https://github.com/BBC-News/alephant-logger-json)
