require 'default_config_group_managed_host_patch'

module ForemanDefaultConfigGroup
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    initializer 'foreman_default_config_group.register_plugin', :after=> :finisher_hook do |app|
      Foreman::Plugin.register :foreman_default_config_group do
      end if (Rails.env == "development" or defined? Foreman::Plugin)
    end

    config.to_prepare do
      ::Host::Managed.send :include, DefaultConfigGroupManagedHostPatch
    end

    rake_tasks do
      load "default_config_group.rake"
    end

  end
end
