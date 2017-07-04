class V1::NewsesController < V1::ApiController
  before_action :load_news, only: [:edit, :update, :destroy]

  def index
    response_success nil, News.all
  end

  def destroy
    if @news.destroy
      response_success t(".delete_success"), @news
    else
      response_error t(".delete_failed"), nil
    end
  end

  def create
    @news = current_admin.news.build news_params
    if @news.save
      response_success t(".add_success"), @news
    else
      response_error t(".add_failed"), @news.errors.full_messages
    end
  end

  def edit
    response_success nil, {news: @news}
  end

  def update
    if @news.update_attributes(news_params)
      response_success t(".save_success"), @news
    else
      response_error t(".save_failed"), nil
    end
  end

  private

  def load_news
    return if @news = News.find_by(id: params[:id])
    response_not_found t(".not_found"), nil
  end

  def news_params
    params.permit :title, :content, :tag_list, :news_category_id,
      image_attributes: [:id, :url]
  end
end
