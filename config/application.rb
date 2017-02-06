require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Servicios
  class Application < Rails::Application

    initializer 'mercadopago.chamber.load', before: :load_environment_config do
      Chamber.load files: [Rails.root + 'config/settings/**/*.{yml,yml.erb}'],
                   decryption_key: Rails.root + 'config/chamber.pem',
                   namespaces: {
                       environment: -> { ::Rails.env },
                       hostname:    -> { Socket.gethostname } }
    end

    config.before_configuration do
      require_relative 'initializers/0_settings'
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = Chamber.env.app.locale

    config.generators do |g|
      g.test_framework :minitest, spec: false, fixture: true
    end

  end
end
