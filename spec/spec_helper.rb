require 'aha-api'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def a_delete(url)
  a_request(:delete, aha_url(url))
end

def a_get(url)
  a_request(:get, aha_url(url))
end

def a_patch(url)
  a_request(:patch, aha_url(url))
end

def a_post(url)
  a_request(:post, aha_url(url))
end

def a_put(url)
  a_request(:put, aha_url(url))
end

def stub_delete(url)
  stub_request(:delete, aha_url(url))
end

def stub_get(url)
  stub_request(:get, aha_url(url))
end

def stub_head(url)
  stub_request(:head, aha_url(url))
end

def stub_patch(url)
  stub_request(:patch, aha_url(url))
end

def stub_post(url)
  stub_request(:post, aha_url(url))
end

def stub_put(url)
  stub_request(:put, aha_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def json_response(file)
  {
    :body => fixture(file),
    :headers => {
      :content_type => 'application/json; charset=utf-8'
    }
  }
end

def aha_url(url)
  if @client
    "https://#{@client.login}:#{@client.password}@dfaha.io#{url}"
  else
    "https://dfaha.io#{url}"
  end
end
