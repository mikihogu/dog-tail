class SearchesController < ApplicationController
  # before_action :authenticate_member!

  def search
    @posts = Post.all 
    @categories = Category.all
    if params[:category]
      @category = Category.find_by(name: params[:category])
      @posts = @category.posts
    end
    @word = params[:word]
    if params[:word].present?
      # splitで正規表現を使ってキーワードを空白(全角・半角・連続)分割する
      #   連続した空白も除去するので、最後の“+”がポイント
      @keywords = params[:word].split(/[[:blank:]]+/)

      @keywords.each_with_index do |keyword, i|
        # 1回目のループでは、1つ目のワードで検索
        #   結果を@postsに詰め込む
        @posts = @posts.search(keyword) if i == 0

        # 2回目以降のループでは、1回目の結果を更にモデル定義の検索メソッドで絞り込みしていく
        #   結果を@postsに詰め込む
        @posts = @posts.merge(@posts.search(keyword), rewhere: true) if i != 0
      end
    end

    tag_ids = params[:tag_ids]&.select(&:present?)
    if tag_ids.present?
      @posts = @posts.joins(:post_tags).where(post_tags: {tag_id: tag_ids}).group("posts.id").having("count(*) = #{tag_ids.length}")
    end
    @posts = @posts.send(params[:condition]) if params[:condition]
  end

end
