require 'chamber/commands/securable'
require 'chamber/commands/secure'

namespace :chamber do

  desc 'Secure keys'
  task secure: :environment do
    environment = prepare_params(ARGV[1..1]).first
    basepath = environment ? "#{Rails.root}/script/deploy/#{environment}/config" : "#{Rails.root}/config"
    encryption_key = "#{basepath}/chamber.pem.pub"
    files = ["#{basepath}/settings.yml","#{basepath}/settings/*.{yml,yml.erb}"]
    puts "Basepath : #{basepath}"
    puts "Encryption_key : #{encryption_key}"
    puts "Files path : #{files}"
    options = {
        rootpath: Rails.root,
        basepath: basepath,
        encryption_key: encryption_key,
        files: files }

    # system "bundle exec chamber secure --basepath=#{basepath} --encryption-key=#{encryption_key} --files=#{files}"
    Chamber.load options
    Chamber.secure
  end

  def prepare_params(args)
    args.each do |arg|
      task arg.to_sym do ; end
    end
    args
  end

end