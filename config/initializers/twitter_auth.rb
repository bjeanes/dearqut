yaml        = YAML.load_file(File.join(Rails.root, 'config', 'twitter_auth.yml'))
TwitterAuth = yaml[Rails.env] || {}
