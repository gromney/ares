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

  def self.train_next language #https://www.codewars.com/api/v1/code-challenges/:language/train
    post("code-challenges/#{language}/train",
      :headers => { "Authorization" => ENV['CODEWARS_API_KEY'] , "peek" => "true" }
    )
  end

  def self.train_kata kata, language #https://www.codewars.com/api/v1/code-challenges/:id_or_slug/:language/train
    post("code-challenges/#{kata}/#{language}/train",
      :headers => { "Authorization" => ENV['CODEWARS_API_KEY'] , "peek" => "true" }
    )
  end

  #https://www.codewars.com/api/v1/code-challenges/projects/:project_id/solutions/:solution_id/attempt
  def self.attempt(project_id,solution_id)
    post("code-challenges/projects/#{project_id}/solutions/#{solution_id}/attempt",
      :headers => { "Authorization" => ENV['CODEWARS_API_KEY'] , "code" => "function(){//example code\n}" }
    )
  end
end
