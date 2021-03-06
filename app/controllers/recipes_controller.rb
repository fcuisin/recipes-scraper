require "open-uri"
require "nokogiri"

class RecipesController < ApplicationController
  def new
    if params[:search] == "" || params[:search] == nil
      if params[:search] == ""
        flash[:alert] = "Empty Field"
      end
    else
      @search = params[:search].downcase
      flash[:success] = "Great move"
      scraper
    end
  end

  def scraper
    html = open("http://www.marmiton.org/recettes/recherche.aspx?aqt=#{@search}").read

    doc = Nokogiri::HTML(html, nil, "utf-8")
    # 2. For the first five results
    @results = []
    doc.search(".recipe-card").first(5).each do |element|
    # 3. Create recipe and store it in results
      name = element.search('.recipe-card__title').text.strip
      duration = element.search('.recipe-card__duration__value').text.strip
      rating = element.search('.recipe-card__rating__value').text.strip
      link = element.search('.recipe-card-link').attribute('href').value
      @results << Recipe.new(name: name, duration: duration, rating: rating, link: link)
    end
  end
end
