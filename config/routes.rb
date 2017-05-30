Rails.application.routes.draw do


  get '/mypage/show', to: 'students#lesson_index'
  get '/mypage', to: 'students#index'

  post '/students/new', to: 'reservations#create'
  get '/students/new', to: 'students#new'


  get '/students/:id/edit', to: 'reservations#edit'
  get '/students/:id', to: 'students#show'
  patch '/students/:id', to: 'reservations#update'
  put '/students/:id', to: 'reservations#update'
  delete '/students/:id', to: 'reservations#destroy'

  get '/students/complete', to: 'students#complete'




  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/top', to: 'top#index'

  get 'extra/sendmail'

  post   '/guest_users/new', to: 'guest_users#create'
  get    '/guest_users/new',  to: 'guest_users#new'

  get    '/guest_users/:id/edit', to: 'guest_users#edit'
  patch  '/guest_users/:id', to: 'guest_users#update'
  put    '/guest_users/:id', to: 'guest_users#update'

  resources :users


  resources :lessons
  resources :lessons do
    member do #resourcesで用意される7つのアクション（以外）で独自のアクションを呼び出すときに使用。
      get 'show_image' #特定のデータを対象をしたアクションを呼び出す。= get 'show_image'
    end
  end
  #この表記により<img src="/lesson/:id/show_image">で画像にアクセスできるようになる
  #image_tagでshow_image_lessons_path(id)を指定することができるようになります。


  resources :reservations
end
