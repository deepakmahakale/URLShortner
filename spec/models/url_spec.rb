RSpec.describe Url, type: :model do
  context 'Model validations' do
    it 'validates presence of target_url' do
      url = FactoryBot.build(:url, target_url: nil)
      url.valid?
      expect(url.errors).to have_key(:target_url)
    end

    it 'creates slug on creating the record' do
      url = FactoryBot.create(:url, slug: nil)
      expect(url.slug).not_to be_nil
    end

    it 'strips the protocol www prefix and trailing / before saving' do
      url_with_protocol = 'https://www.google.com/'
      processed_url = Url.send(:generate_target_url, url_with_protocol)
      expect(processed_url).to eq('google.com')
    end
  end
end
