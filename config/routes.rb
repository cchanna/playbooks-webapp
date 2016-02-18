Rails.application.routes.draw do
root 'main#home'

resources :characters, except: [:index, :destroy] do
  resources :relationships, only: [:new, :create]
  resources :tools, only: [:new, :create]
  member do
    get 'setting_symbol'
    get 'setting_other'
    patch 'update_look'
    patch 'update_vows'
    namespace :edit, module: nil do
      get 'moves', to: "characters#edit_moves"
      get 'name',  to: "characters#edit_name"
      get 'look',  to: "characters#edit_look"
      get 'trust', to: "characters#edit_trust"
      get 'vows',  to: "characters#edit_vows"
    end
    post 'increment_spirit'
    post 'decrement_spirit'
  end
  resources :fates, only: [:new, :edit, :create]
  resources :spells, only: [:new, :create]
  resources :improvements, only: [:new, :create, :edit]
end
resources :dire_fates, only: [:update]

resources :moves, only: [:edit, :update, :create] do
  resources :move_fields, only: [:create, :new, :edit, :update]
end

resources :move_fields, only: [:destroy]
resources :gifts, only: [:edit, :update]
resources :tools, only: [:show, :destroy, :edit, :update]
resources :spells, only: [:edit, :update, :destroy, :show]
resources :improvements, only: [:update, :destroy]

resources :fates, only: [:update] do
  member do
    post 'increment'
    post 'decrement'
    post 'complete'
    post 'uncomplete'
  end
end


resources :relationships, only: [:show, :destroy] do
  member do
    post 'increment'
    post 'decrement'
  end
end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
