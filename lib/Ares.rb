#require "/Ares/version"
require "open-uri"
require "json"

module Ares
  # Your code goes here...
  @@url = 'http://www.codewars.com/api/v1'

  def self.get_user (user)
    respons = JSON.parse(open("#{@@url}/users/#{user}").read)
  end
end
