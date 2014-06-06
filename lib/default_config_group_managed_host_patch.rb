module DefaultConfigGroupManagedHostPatch
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      class << self
        alias_method_chain :import_host_and_facts, :ensure_config_group
      end
    end
  end

  module ClassMethods
    def import_host_and_facts_with_ensure_config_group hostname, facts, certname = nil, proxy_id = nil
      host, result = import_host_and_facts_without_ensure_config_group(hostname, facts, certname, proxy_id)

      unless SETTINGS[:default_config_group]
        Rails.logger.warn "DefaultConfigGroup: Could not load default_config_group from settings, check config."
        return host, result
      end

      # Ensure a specific config group is either in the Host's hostgroup ancestors, or on the Host itself
      config_group = ConfigGroup.find_by_name(SETTINGS[:default_config_group])

      if config_group.present?
        if host.parent_config_groups.include?(config_group) || host.config_groups.include?(config_group)
          Rails.logger.debug "DefaultConfigGroup: #{config_group.name} is already present on #{host.name}: skipping"
        else
          host.config_groups << config_group
          host.save(:validate => false)
          Rails.logger.debug "DefaultConfigGroup: ConfigGroup #{config_group.name} added to #{host.name}"
        end
      else
        Rails.logger.debug "DefaultConfigGroup: #{SETTINGS[:default_config_group]} not found, host not updated"
      end

      return host, result
    end

  end
end
