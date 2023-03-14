class SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
    @word = params[:word]
    @posts = Post.looks(@word)
  end

  # def post.search_for(word)
  #   @post = Post.where("name LIKE?","%#{word}%")
  # end

end
