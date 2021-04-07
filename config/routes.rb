Rails.application.routes.draw do
root to:  'bookers#top'
 devise_for :users
 resources :users do
 	member do
      get 'followers'
      get 'followings'
    end
 end
   resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
 get 'home/about' => 'bookers#about'
 get 'post_image' => 'post_images#index'
 get '/search', to: 'search#search'

end
