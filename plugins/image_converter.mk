################################################################################
# Constants

# Attribute marker used to denote source files for conversion
ATTR_MARK = to-
RSYNC_EXCLUDES += *.@$(ATTR_MARK)*

# Attribute for monochrome images
ATTR_MONOCHROME = monochrome

# Extension for images
EXT_IMAGES = png jpg jpeg

# Extension for images to be converted to monochrome
EXT_IMAGES_MONOCHROME = $(addprefix \.@$(ATTR_MARK)$(ATTR_MONOCHROME)\.,$(EXT_IMAGES))

# Regex for for images to be converted to monochrome
REGEX_IMAGES_MONOCHROME = .*\($(call join-with,\|,$(EXT_IMAGES_MONOCHROME))\)

################################################################################
# Functions

# ------------------------------------------------------------------------------
# General

# A literal space.
space := $(subst ,, )

# Joins elements of the list in arg 2 with the given separator.
#   1. Separator
#   2. List
join-with = $(subst $(space),$(1),$(strip $(2)))

################################################################################
# Recipes

# Convert marked images to monochrome.
define monochrome_from_image_template =
%.@$(ATTR_MONOCHROME).png: %.@$(ATTR_MARK)$(ATTR_MONOCHROME).$(1)
	convert $$< \
		-geometry 600x \
		-monochrome \
		$$@
endef
$(foreach extension,$(EXT_IMAGES), \
	$(eval \
		$(call monochrome_from_image_template,$(extension)) \
		) \
	)

