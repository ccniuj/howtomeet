Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, 
    "648864093370-0k1dhjdodg8045m74caruevl2sv1fg51.apps.googleusercontent.com", 
    "Erk7Zx1y-L-SZwUfavkRsFyB", {
      :scope => 'email, profile, https://www.googleapis.com/auth/drive'
  }
end