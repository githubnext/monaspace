#!/usr/bin/env make

FONT_FAMILY := Monaspace
RELEASE_DIR := fonts
VARIANTS := otf variable webfonts
EXCLUDES := webfonts

ifeq ($(OS),Windows_NT)
DEST_DIR := $(shell powershell (Get-Item Env:WINDIR).Value)\Fonts
INSTALL := xcopy /Y /I
MKDIR := mkdir
RM := del /Q

POST_INSTALL = $(foreach font,$(notdir $(INSTALL_FONT_TARGETS)), \
	powershell reg add \"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts\" /v \"$(font) (TrueType)\" /t REG_SZ /d $(font) /f >NUL & \
)
POST_UNINSTALL = $(foreach font,$(notdir $(INSTALL_FONT_TARGETS)), \
	powershell reg delete \"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts\" /v \"$(font) (TrueType)\" /f >NUL & \
)

sep := \\#
else
uname_s := $(shell uname -s)
ifeq ($(uname_s),Darwin)
DEST_DIR := $(HOME)/Library/Fonts
else
DEST_DIR := $(or $(XDG_DATA_HOME),$(HOME)/.local/share)/fonts
POST_INSTALL := /usr/bin/env fc-cache -f
WRAP := 1
endif

INSTALL := /usr/bin/env install -m 644
MKDIR := /usr/bin/env mkdir -p
RM := /usr/bin/env rm -f

POST_UNINSTALL = $(ifeq $(WRAP),1,$(shell rmdir $(install_path) 2>/dev/null))

sep := /
endif

install_path := $(DEST_DIR)$(if $(filter $(WRAP),1),$(sep)$(FONT_FAMILY),)

RELEASE_FONTS := $(wildcard $(RELEASE_DIR)/**/*)
INSTALL_FONTS := $(filter-out \
	$(foreach exclude,$(EXCLUDES),$(wildcard $(RELEASE_DIR)/$(exclude)/*)), \
	$(RELEASE_FONTS) \
)
INSTALL_FONT_TARGETS := $(addprefix $(install_path)$(sep),$(notdir $(INSTALL_FONTS)))

.PHONY: install
install: $(INSTALL_FONT_TARGETS)
	@$(POST_INSTALL)
	@echo Fonts successfully installed in $(install_path)

.PHONY: uninstall
uninstall:
	@$(RM) $(install_path)$(sep)$(FONT_FAMILY)*
	@$(POST_UNINSTALL)
	@echo Fonts successfully uninstalled

$(install_path):
	@$(MKDIR) $@

define install_font_target
$(install_path)$(if $(filter $(OS),Windows_NT),\,)$(sep)%: $(RELEASE_DIR)$(sep)$(1)$(sep)% | $(install_path)
	@$(INSTALL) $$< $(install_path)
endef

$(foreach variant,$(filter-out $(EXCLUDES),$(VARIANTS)), \
	$(eval $(call install_font_target,$(variant))) \
)