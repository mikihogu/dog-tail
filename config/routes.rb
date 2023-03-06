Rails.application.routes.draw do
  # 管理者
  devise_for :admin, skip: [:registraions, passwords], controllers: {
    sessions: "admin/sessions"
  }
  # 会員
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  

end
