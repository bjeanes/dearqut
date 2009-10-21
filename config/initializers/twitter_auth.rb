yaml        = YAML.load(File.join(Rails.root, 'config', 'twitter_auth.yml'))

TwitterAuth = yaml[Rails.env]
