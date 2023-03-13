class YoutubeService < ApplicationService
  def initialize(query)
    @base_url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&order=viewCount"
    @key = ENV.fetch("API_KEY")
    @query = query
  end

  def call
    
    uri = URI("#{@base_url}&q=#{@query}&type=video&videoDefinition=high&key=#{@key}")
    response = Net::HTTP.get(uri)
    result = JSON.parse(response, symbolize_names: true)
    result[:items]
  end
end
