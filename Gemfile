source "https://rubygems.org"

if ENV["PACKCR_LOCAL_PATH"]
  gem "packcr", path: ENV["PACKCR_LOCAL_PATH"]
else
  gem "packcr", git: "https://github.com/wanabe/packcr.git"
end
group :development do
  gem "rake"
  gem "debug"
  gem "rspec"
  gem "rspec-parameterized"
end
