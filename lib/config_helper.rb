module ConfigHelper
  def self.hash()
    if File.exists?('/opt/webrockit-checksync/config/config.yml')
      configs = YAML.load_file('/opt/webrockit-checksync/config/config.yml')
    else
      configs = YAML.load_file('config/config.yml')
    end
    return configs
  end
end