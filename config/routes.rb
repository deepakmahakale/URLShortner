Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :urls, only: %i(index create destroy) do
        collection do
          get 'fetch/:slug', to: 'urls#fetch'
        end
      end
    end
  end

  resources :urls, only: %i(index create)

  get ':slug', to: 'urls#target', constraints: { slug: /\w?/ }, as: :short

  root 'urls#index'
end
