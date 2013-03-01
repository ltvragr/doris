class SearchController < ApplicationController
  def search
    @search_string = params[:query]
    
    @users = User.search do
      keywords params[:query]
    end.results

    @labs = Lab.search do
      keywords params[:query]
    end.results

    @projects = Project.search do
      keywords params[:query]
    end.results

  end
end