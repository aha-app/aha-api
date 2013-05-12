require 'spec_helper'

describe AhaApi::Client do

  before do
    AhaApi.reset
  end

  it "sets a default user agent" do
    stub_request(:get, "https://api.github.com/rate_limit").
      with(:headers => {:user_agent => AhaApi.user_agent }).
      to_return(:status => 200, :body => '')
  end

  it "allows a custom user agent" do
    AhaApi.user_agent = 'My mashup'

    stub_request(:get, "https://api.github.com/rate_limit").
      with(:headers => {:user_agent => 'My mashup' }).
      to_return(:status => 200, :body => '')
  end

  it "works with basic auth and password" do
    stub_get("https://foo:bar@api.github.com/repos/baz/quux/commits?per_page=35&sha=master").
      to_return(:status => 200, :body => '{"commits":[]}', :headers => {})
    expect {
      AhaApi::Client.new(:login => 'foo', :password => 'bar').commits('baz/quux')
    }.not_to raise_exception
  end

  it "configures faraday from faraday_config_block" do
    mw_evaluated = false
    AhaApi.configure do |c|
      c.faraday_config { |f| mw_evaluated = true }
    end
    stub_request(:get, "https://api.github.com/rate_limit").
      to_return(:status => 200, :body => '')
    client = AhaApi::Client.new()
    expect(mw_evaluated).to eq(true)
  end

  describe "api_endpoint" do

    after(:each) do
      AhaApi.reset
    end

    it "defaults to https://api.github.com" do
      client = AhaApi::Client.new
      expect(client.api_endpoint).to eq('https://api.github.com/')
    end

    it "is set " do
      AhaApi.api_endpoint = 'http://foo.dev'
      client = AhaApi::Client.new
      expect(client.api_endpoint).to eq('http://foo.dev/')
    end

  end

  describe "endpoint url" do

    it "defaults to api.github.com" do
      stub_request(:get, 'https://api.github.com').
        to_return(:body => 'octocat')
      response = AhaApi.get '/'
      expect(response).to eq('octocat')
    end

    it "can be set in the options" do
      stub_request(:get, 'http://wynnnetherland.com').
        to_return(:body => 'pengwynn')
      response = AhaApi.get '/', {:endpoint => 'http://wynnnetherland.com'}
      expect(response).to eq('pengwynn')
    end

  end

  describe "error handling" do

    it "displays validation errors" do
      stub_patch("https://foo:bar@api.github.com/repos/pengwynn/api-sandbox").
        to_return(json_response("validation_failed.json"))

      response = AhaApi::Client.new(:login => 'foo', :password => 'bar').update_repository('pengwynn/api-sandbox')
      expect(response.errors.first.message).to eq('name is too short (minimum is 1 characters)')
    end

  end


end
