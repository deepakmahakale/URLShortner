class UrlsController < ApplicationController
  before_action :set_url, only: :destroy

  LIMIT = 10

  def index
    @urls = Url.order(id: :desc).page(params[:page]).per(LIMIT)
    @url = Url.new
  end

  def target
    @url = Url.find_by!(slug: params[:slug])
    if @url
      redirect_to @url.target_url_with_scheme
    else
      redirect_to urls_path, alert: 'URL not found'
    end
  end

  def create
    @url = Url.short_url(url_params[:target_url])
    if @url
      redirect_to urls_path, notice: 'Short url created'
    else
      @url = Url.new(url_params)
      if @url.save
        redirect_to urls_path, notice: 'Short url created'
      else
        @urls = Url.order(id: :desc).page(params[:page]).per(LIMIT)
        render :index
      end
    end
  end

  private

  def set_url
    @url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(:target_url)
  end
end
