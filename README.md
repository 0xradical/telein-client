# Telein::Client

The 'telein-client' gem allows the access for
the Telein API in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'telein-client', :require => 'telein'

Or install it yourself as:

    $ gem install telein-client

## Usage

    require 'telein'

    # if you do not set this properly, it's going to return 999 responses
    Telein.api_key = 'your_api_key'

    client = Telein::Client.new
    client.carrier_code_for('(12) 3434-5656') # => 41

## About Telein

[Telein](http://www.telein.com.br/) is a service that
allows the fetching of carrier codes for Brazilian phones,
through simple GET requests to its servers.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## MIT License

Copyright (c) 2013 Thiago Brandão Damasceno

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

