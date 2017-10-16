require 'spec_helper'

describe AhaApi::Client do

  before do
    AhaApi.reset
  end

  it "sets a default user agent" do
    stub_request(:post, "https://a.aha.io/api/v1/features").
      with(:headers => {:user_agent => AhaApi.user_agent }).
      to_return(:status => 200, :body => '')
      
    AhaApi::Client.new(:domain => "a").create_feature("New feature", "Description")
  end

  it "allows a custom user agent" do
    AhaApi.user_agent = 'Custom user agent'

    stub_request(:post, "https://a.aha.io/api/v1/features").
      with(:headers => {:user_agent => 'Custom user agent'}).
      to_return(:status => 200, :body => '')
      
    AhaApi::Client.new(:domain => "a").create_feature("New feature", "Description")
  end

  it "works with basic auth and password" do
    stub_get("https://a.aha.io/api/v1/features/APP-1").
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
    stub_request(:post, "https://a.aha.io/api/v1/features").
      to_return(:status => 200, :body => '')
    client = AhaApi::Client.new(:domain => "a")
    client.create_feature("New feature", "Description")
    expect(mw_evaluated).to eq(true)
  end

  it "handles errors" do
    # Hash style
    errors = AhaApi::Error.new(status: 400, method: 'PUT', url: '/foo', body: '{"error":"Validation failed","errors":{"message":"Workflow status can\'t be blank"}}')
    expect(errors.message).to eq("PUT /foo => 400 Validation failed: Workflow status can't be blank")
    # Array style
    errors = AhaApi::Error.new(status: 400, method: 'PUT', url: '/foo', body: '{"error":"Validation failed","errors":[{"message":"Workflow status can\'t be blank"}]}')
    expect(errors.message).to eq("PUT /foo => 400 Validation failed: Workflow status can't be blank")
  end

  describe "api_endpoint" do

    after(:each) do
      AhaApi.reset
    end

    it "defaults to https://domain.aha.io" do
      client = AhaApi::Client.new(:domain => "myaccount")
      expect(client.api_endpoint).to eq('https://myaccount.aha.io/')
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
      stub_request(:get, 'http://a.chris.com').
        to_return(:body => 'k1w1')
      response = AhaApi::Client.new(:domain => "a", :url_base => "http://chris.com").get '/'
      expect(response).to eq('k1w1')
    end

  end


end
