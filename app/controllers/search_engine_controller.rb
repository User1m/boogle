include SearchEngineHelper

class SearchEngineController < ApplicationController
  before_action :indexing_params, only: [:index]
  before_action :searching_params, only: [:search]

  def index
    head (save_page_content(indexing_params) ? :no_content : 400), content_type: "application/json"
  end

  def search
    matches = []
    if !searching_params[:query].blank? 
      results = PageContent.where("content like ?", "%#{searching_params[:query]}%")
      results.each do |result| 
        matches.push({page_id: result[:page_id], score: 0})
      end
    end
    render json: { matches: matches }, status: (searching_params.empty? ? 404 : :ok)
  end

  private
  def indexing_params
    params.permit(:page_id, :content)
  end

  def searching_params
    params.permit(:query)
  end
end
