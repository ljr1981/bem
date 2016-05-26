note
	description: "[
		Representation of an effected {BEM_BANNER_ROOT}.
		]"
	EIS: "src=http://themes.typepad.com/"
	EIS: "src=http://themes.typepad.com/guide/banner/"
	EIS: "src=http://static.typepad.com/.shared/themes/typepad/theme-clean/typepad-theme-banner.css"

deferred class
	BEM_BANNER_ROOT

inherit
	BEM_BLOCK

	CSS_CONSTANTS
		undefine
			default_create,
			out
		end

feature -- Basic Operations

	generate
			-- `generate' Current to CSS.
		deferred
		end

feature -- Setters

	background: STRING attribute Result := "#f5f5f5" end
	set_background (a_value: like background) do background := a_value ensure background ~ a_value end

	margin: INTEGER
	set_margin (a_value: like margin) do margin := a_value ensure margin ~ a_value end

	padding: INTEGER
	set_padding (a_value: like padding) do padding := a_value ensure padding ~ a_value end

end
