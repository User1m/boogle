include SearchEngineHelper
require 'set'

class SearchEngineController < ApplicationController
  before_action :indexing_params, only: [:index]
  before_action :searching_params, only: [:search]
  skip_before_action :verify_authenticity_token, only: [:index]

  def index
    head (save_page_content(indexing_params) ? :no_content : 400), content_type: "application/json"
  end

  def search
    matches = []
    results = Set.new
    if !searching_params[:query].blank? 
      query_strings = strip_downcase_and_remove_punctuation(searching_params[:query]).split
      fetch_results_for_query_strings(query_strings, results)
      calc_score_for_matches(query_strings, results, matches)
    end
    render json: { query: searching_params[:query] , matches: matches.sort_by {|m| m[:score]}.reverse! }, status: (searching_params.empty? ? 404 : :ok) 
  end

  private

  def fetch_results_for_query_strings(query_strings, results)
    query_strings.each do |q|
      matches = get_matches(q).to_a
      matches.each do |m| 
        results.add?(m)
      end
    end
  end

  def get_matches(str)
    DbTextSearch::FullText.new(PageContent, :content).search(" #{str} ")
  end

  def calc_score_for_matches(query_strings, results, matches = [])
    results.each do |result|
      score = 0
      query_strings.each do |str|
        if result[:content].match(/\b#{str}\b/i)
          score += 1
        end
      end
      matches.push({ pageId: result[:page_id], score: score, content:result[:content] })
    end
  end

  def indexing_params
    params.permit(:page_id, :content)
  end

  def searching_params
    params.permit(:query)
  end
end
