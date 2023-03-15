class SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
    # @word = params[:word]
    # @posts = Post.looks(@word)

    # splitで正規表現を使ってキーワードを空白(全角・半角・連続)分割する
    #   連続した空白も除去するので、最後の“+”がポイント
    @keywords = params[:word].split(/[[:blank:]]+/)

    @posts = Post.none # 空のオブジェクト生成

    @keywords.each_with_index do |keyword, i|
      # 1回目のループでは、1つ目のワードで検索
      #   結果を@postsに詰め込む
      @posts = Post.search(keyword) if i == 0

      # 2回目以降のループでは、1回目の結果を更にモデル定義の検索メソッドで絞り込みしていく
      #   結果を@postsに詰め込む
      @posts = @posts.merge(@posts.search(keyword), rewhere: true) if i != 0
    end
  end

end
