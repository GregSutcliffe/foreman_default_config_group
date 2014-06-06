require 'test_plugin_helper'

class DefaultConfigGroupTest < ActiveSupport::TestCase
  setup do
    disable_orchestration
    User.current = User.find_by_login "admin"
  end

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end

  def setup_default_config_group
    # The settings.yml fixture in Core wipes out the Setting table,
    # so we use FactoryGirl to re-create it
    @config_group = ConfigGroup.create(:name => "test1")
    SETTINGS[:default_config_group] = "test1"
  end

  test "not specifying a config group does nothing" do
    setup_default_config_group
    SETTINGS[:default_config_group] = nil
    puts SETTINGS[:default_config_group]
    raw = parse_json_fixture('/facts.json')

    assert Host.import_host_and_facts(raw['name'], raw['facts'])
    assert_equal [], Host.find_by_name('sinn1636.lan').config_groups
  end

  test "specifying a missing config group does nothing" do
    setup_default_config_group
    SETTINGS[:default_config_group] = "test2"
    raw = parse_json_fixture('/facts.json')

    assert Host.import_host_and_facts(raw['name'], raw['facts'])
    assert_equal [], Host.find_by_name('sinn1636.lan').config_groups
  end

  test "host without config_group gains the default config_group" do
    setup_default_config_group
    raw = parse_json_fixture('/facts.json')

    assert Host.import_host_and_facts(raw['name'], raw['facts'])
    assert_equal @config_group, Host.find_by_name('sinn1636.lan').config_groups.first
  end

  test "host with hostgroup containing the config_group does not gain it again" do
    setup_default_config_group
    raw = parse_json_fixture('/facts.json')

    hostgroup = Hostgroup.create(:name => "Test Group")
    hostgroup.config_groups << @config_group
    hostgroup.save(:validate => false)
    raw = parse_json_fixture('/facts.json')

    host, result = Host.import_host_and_facts_without_ensure_config_group(raw['name'], raw['facts'])
    host.hostgroup = hostgroup
    host.save(:validate => false)

    assert Host.import_host_and_facts(raw['name'], raw['facts'])
    assert_equal [], Host.find_by_name('sinn1636.lan').config_groups
  end

  test "host with hostgroup with parent containing the config_group does not gain it again" do
    setup_default_config_group
    raw = parse_json_fixture('/facts.json')

    hostgroup_p = Hostgroup.create(:name => "Test Group Parent")
    hostgroup_p.config_groups << @config_group
    hostgroup_p.save(:validate => false)
    hostgroup_c = Hostgroup.create(:name => "Test Group Child", :parent => hostgroup_p)
    raw = parse_json_fixture('/facts.json')

    host, result = Host.import_host_and_facts_without_ensure_config_group(raw['name'], raw['facts'])
    host.hostgroup = hostgroup_c
    host.save(:validate => false)

    assert Host.import_host_and_facts(raw['name'], raw['facts'])
    assert_equal [], Host.find_by_name('sinn1636.lan').config_groups
  end

end
