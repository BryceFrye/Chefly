class PagesController < ApplicationController
  def home
    @recipes = Recipe.limit(10).order("created_at desc")
  end
end
