class Url < ActiveRecord::Base
  validates :target_url, presence: true
  before_create :create_short_url, unless:-> { slug? }

  def self.short_url(url)
    generated_url = generate_target_url(url)
    find_by(target_url: generated_url) if exists?(target_url: generated_url)
  end

  def target_url_with_scheme
    "http://#{target_url}"
  end

  private

  def self.generate_target_url(url)
    url.sub!(/^https:\/\//, '')
    url.sub!(/^www\./, '')
    url.sub!(/\/$/, '')
    url
  end

  def create_short_url
    self.slug = loop do
      slug = (id.to_s + rand(50..100).to_s).reverse.to_i.to_s(36)
      break slug unless Url.exists?(slug: slug)
    end
  end
end
