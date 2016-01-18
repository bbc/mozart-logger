# Mozart::Logger

Private gem for setting up structured logging and metrics for use within our Mozart service applications.

It is an abstraction wrapping around our open-source software [Alephant Logger](https://github.com/BBC-News/alephant-logger).

## Installation

Add this line to your application's Gemfile:

```ruby
group :production do
  gem "mozart-logger", "1.0.0", :git => "git@github.com:bbc/mozart-logger.git"
end
```

> Note: this is a private gem published to  
> https://gemstore.news.tools.bbc.co.uk/nexus  

And then execute:

    $ bundle install

## Setup

```rb
require "mozart/logger"

namespace = { 
  :namespace => ENV["CLOUDWATCH_NAMESPACE"]
}

Mozart::Logger.setup namespace, ENV["APP_LOG_LOCATION"] # configures Alephant Logger

use Rack::CommonLogger, Alephant::Logger.get_logger # optional
```

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
> [Alephant-Logger-CloudWatch](https://github.com/BBC-News/alephant-logger-cloudwatch) and [Alephant-Logger-JSON](https://github.com/BBC-News/alephant-logger-json)
