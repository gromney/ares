#require "/Ares/version"
#require "open-uri"
#require "json"
require "httparty"

module Ares
  # Your code goes here...
  include HTTParty
  #@@url = 'http://www.codewars.com/api/v1'
  base_uri 'http://www.codewars.com/api/v1'

  def self.get_user (user)
    #respons = JSON.parse(open("#{@@url}/users/#{user}").read)
    get("/users/#{user}")
  end

  def self.get_challenge (id)
    #respons = JSON.parse(open("#{@@url}/code-challenges/#{id}").read)
    get("/code-challenges/#{id}")
  end

  def self.train language
    {:description => ''}
  end
end
