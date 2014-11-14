Puppet::Type.newtype(:rabbitmq_shovel) do
  desc 'shovel creation.'

  ensurable
  newparam(:name) do
    desc 'bleh'
  end
  newparam(:label) do
    desc 'name of the shovel'
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
