Rails.application.routes.draw do
  root to: 'public/homes#new_arrival'

  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do

    #いいね関連のURL
    resources :likes, only: [:create, :destroy]
    get ':display_name/post_likes' => "likes#post_likes", as: "post_likes"
    get ':display_name/comment_likes' => "likes#comment_likes", as: "comment_likes"
    get ':display_name/reply_likes' => "likes#reply_likes", as: "reply_likes"

    get 'likes_ranking_post' => "homes#likes_ranking", as: "likes_ranking_post"

    #ユーザー情報関連のURL
    get '/:display_name/mypage' => "end_users#mypage", as: "mypage"
    get '/:display_name/mypage/edit' => "end_users#edit", as: "edit_mypage"
    patch '/:display_name/mypage' => "end_users#update", as: "update_mypage"
    get '/:display_name/unsubscribe' => "end_users#unsubscribe", as: 'unsubscribe'
    patch '/:display_name/withdraw' => "end_users#withdraw", as: 'withdraw'

     #検索関連のURL
    get '/searches' => "searches#index", as: 'search'
    get '/searches/result' => "searches#result", as: 'search_result'

    #ユーザータイムラインのURL
    get '/:display_name' => "end_users#timeline", as: "timeline"
    get '/:display_name/comments_list' => "end_users#comments_list", as: "comments_list"
    get '/:display_name/replies_list' => "end_users#replies_list", as: "replies_list"

    #フォロー関連のURL
    post '/:display_name/following' => "follow_followers#create", as: "following"
    delete '/:display_name/unfollowing' => "follow_followers#destroy", as: "unfollow"
    get '/:display_name/follows' => "follow_followers#follows", as: "follow_index"
    get '/:display_name/followers' => "follow_followers#followers", as: "follower_index"

    #投稿関連のURL
    get '/:display_name/posts/new' => "posts#new", as: "new_post"
    get '/:display_name/posts/:id' => "posts#show", as: "post"
    post '/:display_name/posts' => "posts#create", as: "posts"
    get '/:display_name//:id/edit' => "posts#edit", as: "edit_post"
    patch '/:display_name/:id' => "posts#update", as: "update_post"
    delete '/:display_name/:id' => "posts#destroy", as: "destroy_post"

    #コメント関連のURL
    post '/:display_name/:post_id/comments' => "comments#create", as: "comments"
    get '/:display_name/:post_id/comments/:id' => "comments#show", as: "comment"
    get '/:display_name/:post_id/comments/:id/edit' => "comments#edit", as: "edit_comment"
    patch '/:display_name/:post_id/comments/:id' => "comments#update", as: "update_comment"
    delete '/:display_name/:post_id/comments/:id' => "comments#destroy", as: "destroy_comment"

    #リプライ関連のURL
    post '/:display_name/:post_id/:comment_id/replies' => "replies#create", as: "replies"
    get '/:display_name/:post_id/:comment_id/replies/:id' => "replies#show", as: "reply"
    get '/:display_name/:post_id/:comment_id//replies/:id/edit' => "replies#edit", as: "edit_reply"
    patch '/:display_name/:post_id/:comment_id/replies/:id' => "replies#update", as: "update_reply"
    delete '/:display_name/:post_id/:comment_id/replies/:id' => "replies#destroy", as: "destroy_reply"

  end

  namespace :admin do
    get '/end_users/:id/account_suspension' => "end_users#account_suspension", as: 'account_suspension'
    patch '/end_users/:id' => "end_users#suspended", as: 'suspended'

    resources :end_users, only: [:index, :show]

    get '/searches' => "searches#index", as: 'search'
    get '/searches/result' => "searches#result", as: 'search_result'

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
