class SearchesController < ApplicationController
  # before_action :authenticate_admin!
  # before_action :authenticate_member!

  def search
    @posts = Post.all.page(params[:page]).per(4)
    # カテゴリー別タブ表示
    @categories = Category.all
    if params[:category]
      @category = Category.find_by(name: params[:category])
      @posts = @category.posts.page(params[:page]).per(4)
    end
    # キーワード検索結果
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

    @tag_ids = params[:tag_ids]&.select(&:present?)
    if @tag_ids.present?
      @tag_word = "タグ: "
      @tag_ids.each do |id|
        @tag_word = @tag_word + ' ' + Tag.find(id).name if id != ""
      end
      @posts = @posts.joins(:post_tags).where(post_tags: {tag_id: @tag_ids}).group("posts.id").having("count(*) = #{@tag_ids.length}").page(params[:page]).per(4)
    end
    
    # 並べ替え  #三項演算子
    @posts = params[:condition] ? @posts.send(params[:condition]) : @posts.order(created_at: :desc)
    if params[:condition] == "most_favorited"
      # posts = Post.most_favorited
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
    end
    
    # @posts = @posts.send(params[:condition]) if params[:condition]
    # if params[:condition] == "most_favorited"
    #   @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(3)
    # end
  end

end
