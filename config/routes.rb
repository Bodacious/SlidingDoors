Rails.application.routes.draw do
  namespace :users do
    get ":user_id/addresses/correspondence" => "addresses#correspondence"
  end

  namespace :merchants do
    get ":merchant_id/addresses/correspondence" => "addresses#correspondence"
  end

  root to: "users/addresses#correspondence"
end
