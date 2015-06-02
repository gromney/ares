require 'spec_helper'
require 'webmock'
include WebMock::API

describe Ares do
  let(:kata) {'anything-to-integer'}
  let(:language) {:ruby}
  body = "{\"name\":\"Geronimo Romney\",
          \"description\":\"kata description\",
          \"success\":\"true\",
          \"exampleFixture\":true,
          \"dmid\":\"4rsdaDf8d\"}"

  describe "#get_user" do
    before do
      # body = "{\"name\":\"Geronimo Romney\"}"
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
      stub_request(:post, "http://www.codewars.com/api/v1code-challenges/ruby/train").
        with(:headers => {'Authorization'=> ENV['CODEWARS_API_KEY'], 'peek'=>'true'}).
        to_return(:status => 200, :body => body, :headers => {:content_type => 'application/json'})
    end
    context 'when valid language' do
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
    before do
      stub_request(:post, "http://www.codewars.com/api/v1code-challenges/anything-to-integer/ruby/train").
      with(:headers => {'Authorization'=> ENV['CODEWARS_API_KEY'], 'peek'=>'true'}).
      to_return(:status => 200, :body => body, :headers => {:content_type => 'application/json'})
    end
    context 'when valid parameters (kata,language)' do
      it "should return 'success:true'" do
        expect(Ares.train_kata(kata,language)).to include 'success'
        expect(Ares.train_kata(kata,language)['success']).to eq 'true'
      end

      it "should return 'exampleFixture'" do
        expect(Ares.train_kata(kata,language)).to include 'exampleFixture'
      end
    end
  end

  #https://www.codewars.com/api/v1/code-challenges/projects/:project_id/solutions/:solution_id/attempt
  describe "#attempt" do
    let(:project_id) {'523f66fba0de5d94410001cb'}
    let(:solution_id) {'53bc968d35fd2feefd000013'}
    before do
      stub_request(:post, "http://www.codewars.com/api/v1code-challenges/projects/523f66fba0de5d94410001cb/solutions/53bc968d35fd2feefd000013/attempt").
        with(:headers => {'Authorization'=>ENV['CODEWARS_API_KEY'], 'code'=>"function(){//example code\n}"}).
        to_return(:status => 200, :body => body, :headers => {:content_type => 'application/json'})
    end
    context "current solution" do

      it "should return 'dmid:4rsdaDf8d'" do
        expect(Ares.attempt(project_id,solution_id)['dmid']).to eq '4rsdaDf8d'
      end
    end
  end
end
