Puppet::Type.type(:rabbitmq_shovel).provide(:rabbitmq_ctl) do

if Puppet::PUPPETVERSION.to_f < 3
    commands :rabbitmqctl => 'rabbitmqctl'
  else
     has_command(:rabbitmqctl, 'rabbitmqctl') do
       environment :HOME => "/tmp"
     end
  end

#  defaultfor :feature => :posix

#  def self.instances
#    rabbitmqctl('-q', 'list_parameters').split(/\n/).collect do |line|
#      if line =~ /^(^shovel\s+)([a-zA-Z0-9]+)/
#        new(:shovel_name => $2)
#      else
#        raise Puppet::Error, "Shovel line is bad: #{line}"
#      end
#    end
#  end
 
 # def self.get_list_of_shovels
 #    installed_shovels = rabbitmqctl('-q', 'list_parameters')
 #    installed_shovels.split(/\n/).detect do |lines|
 #    line_re = /(shovel+\s+)(\S+)/
 #    line_re.match(lines)
 #     if ! $~.nil?
 #      puts $2
 #     end
 # end
 # def self.get_shovel_source_parameters(string)
     
  def create
    if resource[:label].nil?
      raise Puppet::Error, "null shovel name"
    end
    if resource[:sourceuri].nil?
      raise Puppet::Error, "null source uri"
    end
    if resource[:sourcequeue].nil?
      raise Puppet::Error, "null source queue"
    end
    if resource[:desturi].nil?
      raise Puppet::Error, "null destination uri"
    end
    if resource[:destqueue].nil?
      raise Puppet::Error, "null destination queue"
    end
    if check_for_shovel(resource[:label]).nil?
      puts check_for_shovel(resource[:label])
    shovel_string = String.new(%({ "src-uri": "#{resource[:sourceuri]}", "src-queue": "#{resource[:sourcequeue]}", "dest-uri": "#{resource[:desturi]}", "dest-queue": "#{resource[:destqueue]}"}))
    rabbitmqctl('set_parameter', 'shovel', resource[:label], shovel_string)
    end
  end

  def destroy
    rabbitmqctl('clear_parameter', 'shovel', resource[:label])
  end
  def check_for_shovel(string)
      rabbitmqctl('-q', 'list_parameters').split(/\n/).detect do |line|
        line_regex = /(shovel+\s+)(\S+)/
        if ! line_regex.match(line).nil? 
             return $2
        end
      end
    end
  def exists?
      check_for_shovel(resource[:label]) != nil
  end
end
#    rabbitmqctl('-q', 'list_parameters').split(/\n/).detect do |line|
#      line_regex = /(shovel+\s+)(\S+)/
#      line_regex.match(line)
#      if ! $~.nil?
#        if ! $2 == #{resource[:name]}
#          return nil  
#    end
