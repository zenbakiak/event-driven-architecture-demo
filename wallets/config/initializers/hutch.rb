Hutch::Logging.logger = Rails.logger

amqp_url = URI(ENV.fetch "AMQP_URL")

Hutch::Config.set :uri,         amqp_url.to_s
Hutch::Config.set :mq_api_host, amqp_url.host
