Puppet::Type.newtype(:rabbitmq_shovel) do
  @doc = %q{Creates rabbitmq shovels. These 
     can be between users, vhosts, and rabbitmq clusters.
     
     Example:
     
        rabbitmq_shovel {'mailbrain':
               ensure => present,
               sourceuri => 'amqp://user:password@localhost/vhost',
               sourcequeue => 'mailbrainoutput',
               desturi => 'amqp://user:password@localhost/vhost',
               destqueue => 'frommailbrain',
                }
    }


  ensurable do
    defaultto(:present)
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:name, :namevar => :true)
    desc "name of the shovel"
    validate do |value|
        unless value =~ /^\w+/
          raise ArgumentError, "%s is not a valid shovel name" % value
        end
    end
  end
  newparam(:sourceuri) do
    desc "source uri should be set to the hostname of the rabbitmq server to take data from."
  end
  newparam(:sourcequeue) do
    desc "source queue should be set to the queue to take from."
  end
  newparam(:desturi) do
    desc "destination uri should be set to the hostname of the rabbitmq server to take data from."
  end
  newparam(:destqueue) do
    desc "destination queue should be set to the queue to take from."
  end
end
~
