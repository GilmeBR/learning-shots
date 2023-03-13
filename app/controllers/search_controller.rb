
class SearchController < ApplicationController
  def search

    search_query = params[:query]
    video_results = YoutubeService.new(search_query).call

    if video_results.present?
     # video_url = "https://www.youtube.com/watch?v=#{video_results.first[:id]}"
      render json: {items: video_results }
    else
      render json: { error: "No videos found" }, status: :not_found
    end
  end
end
