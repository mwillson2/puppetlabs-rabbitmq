require puppet
require set
Puppet::Type.type(:rabbitmq_shovel).provide(:rabbitmq_ctl) do

if Puppet::PUPPETVERSION.to_f < 3
    commands :rabbitmqctl => 'rabbitmqctl'
  else
     has_command(:rabbitmqctl, 'rabbitmqctl') do
       environment :HOME => "/tmp"
     end
  end

  defaultfor :feature => :posix

  def self.instances
    rabbitmqctl('-q', 'list_parameters').split(/\n/).collect do |line|
      if line =~ /^(^shovel\s+)([a-zA-Z0-9]+)/
        new(:shovel_name => $2)
      else
        raise Puppet::Error, "Shovel line is bad: #{line}"
      end
    end
  end
 
  def create
    rabbitmqctl('set_parameter', resource[:shovel_name], resource[:source_vhost], resource[:source_queue], resource[:destination_vhost], resource[:destination_queue], resource[:destination_uri], resource[:source_uri])
    if resource[:shovel_name].nil?
      raise Puppet::Error, "null shovel name"
    end
    if resource[:source_uri].nil?
      raise Puppet::Error, "null source uri"
    end
    if resource[:source_vhost].nil?
      raise Puppet::Error, "null source vhost"
    end
    if resource[:source_queue].nil?
      raise Puppet::Error, "null source queue"
    end
    if resource[:destination_uri].nil?
      raise Puppet::Error, "null destination uri"
    end
    if resource[:destination_vhost].nil?
      raise Puppet::Error, "null destination vhost"
    end
    if resource[:destination_queue].nil?
      raise Puppet::Error, "null destination queue"
    end
  end

  def destroy
    rabbitmqctl('clear_parameter', resource[:shovel_name])
  end

  def exists?
    rabbitmqctl('-q', 'list_parameters').split(/\n/).detect do |line|
      line.match(/^#{Regexp.escape(resource[:name])}(\s+(\[.*?\]|\S+)|)$/)
    end
  end
