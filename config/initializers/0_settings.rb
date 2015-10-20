Chamber.load files: [Rails.root+'config/settings.yml',Rails.root + 'config/settings/*.{yml,yml.erb}'],
             decryption_key: Rails.root + 'config/chamber.pem',
             namespaces: { environment: ::Rails.env }
