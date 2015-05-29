require 'spec_helper'
require 'webmock'
include WebMock::API

describe Ares do
  describe "#get_user" do
    before do
      body = "{\"name\":\"Geronimo Romney\"}"
      stub_request(:get, "http://www.codewars.com/api/v1/users/gromney").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => body, :headers => {:content_type => 'application/json'})
    end
    context "when valid user" do
      it 'should return full name of user gromney' do
        expect(Ares.get_user('gromney')['name']).to eq 'Geronimo Romney'
      end
    end
  end

  describe "#train_next" do
    before do
      body = "{\"name\":\"Geronimo Romney\",\"description\":\"kata description\",\"success\":\"true\"}"
      stub_request(:post, "http://www.codewars.com/api/v1code-challenges/ruby/train").
        with(:headers => {'Authorization'=> ENV['CODEWARS_API_KEY'], 'peek'=>'true'}).
        to_return(:status => 200, :body => body, :headers => {:content_type => 'application/json'})
    end
    context 'when valid language' do

      let(:language) {:ruby}

      it "should return the description of todays kata" do
        expect(Ares.train_next(language)['description']).to eq "kata description"
      end
      it "should return 'success:true'" do
        expect(Ares.train_next(language)).to include 'success'
        expect(Ares.train_next(language)['success']).to eq 'true'
      end
    end
  end

  describe "#train_kata" do
    context 'when valid parameters (kata,language)' do
      it { should return "success"}
    end
  end
end
