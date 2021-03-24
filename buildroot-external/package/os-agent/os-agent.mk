################################################################################
#
# foo
#
################################################################################

OS_AGENT_VERSION = 7bff7f5cd223ad439b738cea513cb558a18155c9
OS_AGENT_SITE = $(call github,home-assistant,os-agent,$(OS_AGENT_VERSION))
OS_AGENT_LICENSE = Apache License 2.0
OS_AGENT_LICENSE_FILES = LICENSE
OS_AGENT_GOMOD = github.com/home-assistant/os-agent

define OS_AGENT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/contrib/io.homeassistant.conf \
		$(TARGET_DIR)/etc/dbus-1/system.d/io.homeassistant.conf
	$(INSTALL) -D -m 0644 $(@D)/contrib/haos-agent.service \
		$(TARGET_DIR)/usr/lib/systemd/system/haos-agent.service
endef

define OS_AGENT_GO_VENDORING
	(cd $(@D); \
		$(HOST_DIR)/bin/go mod vendor)
endef

OS_AGENT_POST_PATCH_HOOKS += OS_AGENT_GO_VENDORING

$(eval $(golang-package))