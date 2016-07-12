require "cert_watch/engine"

module CertWatch
  def self.config
    @config ||= Configuration.new
  end

  def self.setup
    yield config

    @client = CertbotClient.new(executable: config.certbot_executable,
                                port: config.certbot_port)

    @installer = PemDirectoryInstaller.new(pem_directory: config.pem_directory,
                                           input_directory: config.certbot_output_directory,
                                           reload_command: config.server_reload_command)
  end

  mattr_accessor :client

  mattr_accessor :installer

  def self.active_admin_load_path
    Dir[CertWatch::Engine.root.join('admin')].first
  end
end