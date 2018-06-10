class Api::V1::UrlsController < Api::V1::ApiController
  before_action :set_url, only: :destroy

  def index
    @urls = Url.all
    render json: @urls
  end

  def fetch
    @url = Url.find_by(slug: params[:slug])
    if @url
      render json: @url
    else
      render json: { message: 'Record Not Found' }, status: :not_found
    end
  end

  def create
    @url = Url.short_url(url_params[:target_url])
    if @url
      render json: @url, status: :created
    else
      @url = Url.new(url_params)
      if @url.save
        render json: @url, status: :created
      else
        render json: @url.errors, status: :bad_request
      end
    end
  end

  def destroy
    @url.destroy
    render json: {}, status: :no_content
  end

  private

  def set_url
    @url = Url.find(params[:id])
  end

  def url_params
    params.permit(:target_url)
  end
end
