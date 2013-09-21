Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, '625258100828963', 'ece1aa6dda665a0b08f05557ecb4fd4a'
end
