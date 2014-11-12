Puppet::Type.newtype(:rabbitmq_shovel) do
  @doc = %q{Creates rabbitmq shovels. These 
     can be between users, vhosts, and rabbitmq clusters.
     
     Example:
     
        rabbitmq_shovel {'mailbrain':
               ensure => present,
               sourceuser => 'shovel',
               sourcepassword => 'shovelpass'
               sourceuri => 'localhost',
               sourcequeue => 'mailbrainoutput',
               sourcevhost => 'vhost1',
               desturi => 'localhost',
               destqueue => 'frommailbrain',
               destuser => 'shovel',
               destpassword => 'shovelpass',
               destvhost => 'vhost2',
                }
    }

  ensurable
  newparam(:sourceuser, :namevar => true) do
    desc "source user to connect to rabbitmq."
    validate do |value|
        unless value =~ /^\w+/
          raise ArgumentError, "%s is not a valid user name" % value
        end
  end
  newparam(:sourcepassword, :namevar => true) do
    desc "source user password."
  end
  newparam(:sourceuri, :namevar => true) do
    desc "source uri should be set to the hostname of the rabbitmq server to take data from."
    validate do |value|
        unless value =~ /^\w+/
          raise ArgumentError, "%s is not a valid hostname" % value
        end
  end
  newparam(:sourcequeue, :namevar => true) do
    desc "source queue should be set to the queue to take from."
  end
  newparam(:sourcevhost, :namevar => true) do
    desc "source vhost to set in the uri, where the queue resides."
  end
  newparam(:destuser, :namevar => true) do
    desc "destination user to connect to rabbitmq."
    validate do |value|
        unless value =~ /^\w+/
          raise ArgumentError, "%s is not a valid user name" % value
        end
  end
  newparam(:destpassword, :namevar => true) do
    desc "destination user password."
  end
  newparam(:desturi, :namevar => true) do
    desc "destination uri should be set to the hostname of the rabbitmq server to take data from."
    validate do |value|
        unless value =~ /^\w+/
          raise ArgumentError, "%s is not a valid hostname" % value
        end
  end
  newparam(:destqueue, :namevar => true) do
    desc "destination queue should be set to the queue to take from."
  end
  newparam(:destvhost, :namevar => true) do
    desc "destination vhost to set in the uri, where the queue resides."
  end
end
~
