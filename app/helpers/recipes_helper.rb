module RecipesHelper

  def image_url(raw_url)
    parsed_url = URI.parse(raw_url)
    query_params = CGI.parse(parsed_url.query)
    query_params['url'].first
  end
end
