class SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
    @word = params[:word]
    @posts = Post.looks(@word)
  end

end
