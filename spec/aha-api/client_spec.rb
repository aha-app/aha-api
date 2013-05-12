require 'spec_helper'

describe AhaApi::Client do

  before do
    AhaApi.reset
  end

  it "sets a default user agent" do
    stub_request(:get, "https://aha.io/api").
      with(:headers => {:user_agent => AhaApi.user_agent }).
      to_return(:status => 200, :body => '')
  end

  it "allows a custom user agent" do
    AhaApi.user_agent = 'Custom user agent'

    stub_request(:get, "https://aha.io/api").
      with(:headers => {:user_agent => 'Custom user agent' }).
      to_return(:status => 200, :body => '')
  end

  it "works with basic auth and password" do
    stub_get("https://foo:bar@a.aha.io/api/v1/features/APP-1").
      to_return(:status => 200, :body => '', :headers => {})
    expect {
      AhaApi::Client.new(:domain => 'a', :login => 'foo', :password => 'bar').feature('APP-1')
    }.not_to raise_exception
  end

  it "configures faraday from faraday_config_block" do
    mw_evaluated = false
    AhaApi.configure do |c|
      c.faraday_config { |f| mw_evaluated = true }
    end
    stub_request(:get, "https://a.aha.io/meta").
      to_return(:status => 200, :body => '')
    client = AhaApi::Client.new(:domain => "a")
    client.aha_meta
    expect(mw_evaluated).to eq(true)
  end

  describe "api_endpoint" do

    after(:each) do
      AhaApi.reset
    end

    it "defaults to https://domain.aha.io" do
      client = AhaApi::Client.new(:domain => "myaccount")
      expect(client.api_endpoint).to eq('https://myaccount.aha.io/')
    end

    it "is set " do
      AhaApi.api_endpoint = 'http://foo.dev'
      client = AhaApi::Client.new
      expect(client.api_endpoint).to eq('http://foo.dev/')
    end

  end

  describe "endpoint url" do

    it "defaults to aha.io" do
      stub_request(:get, 'https://a.aha.io').
        to_return(:body => 'Aha!')
      response = AhaApi::Client.new(:domain => "a").get '/'
      expect(response).to eq('Aha!')
    end

    it "can be set in the options" do
      stub_request(:get, 'http://chris.com').
        to_return(:body => 'k1w1')
      response = AhaApi::Client.new(:domain => "a").get '/', {:endpoint => 'http://chris.com'}
      expect(response).to eq('k1w1')
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
