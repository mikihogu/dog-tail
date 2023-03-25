class SearchesController < ApplicationController
  # before_action :authenticate_admin!
  # before_action :authenticate_member!

  def search
    # キーワードが空欄の場合
    if  params[:word].blank?
      @message = "no keyword"
      redirect_back(fallback_location: root_path)
    end

    # カテゴリー別タブ表示
    @categories = Category.all
    if params[:category]
      @category = Category.find_by(name: params[:category])
      @posts = @category.posts
    else
      @posts = Post.all
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
      @posts = @posts.joins(:post_tags).where(post_tags: {tag_id: @tag_ids}).group("posts.id").having("count(*) = #{@tag_ids.length}")
    end

    # 並べ替え  #三項演算子
    @posts = params[:condition] ? @posts.send(params[:condition]) : @posts.order(created_at: :desc)
    if params[:condition] == "most_favorited"
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
    else
      @posts = @posts.page(params[:page]).per(4)
    end
  end

end
