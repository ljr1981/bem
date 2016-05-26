note
	description: "[
		Representation of an effected {BEM_BANNER_CONTAINER}.
		BEM = "banner__title-strip" or /* Title Strip */ (see EIS below)
		]"
	EIS: "src=http://themes.typepad.com/"
	EIS: "src=http://themes.typepad.com/guide/banner/"
	EIS: "src=http://static.typepad.com/.shared/themes/typepad/theme-clean/typepad-theme-banner.css"

class
	BEM_BANNER_TITLE_STRIP

inherit
	BEM_BANNER_ROOT
		redefine
			name
		end

feature -- Access

	name: STRING attribute Result := "banner__title_strip" end

feature -- Basic Operations

	generate
			-- <Precursor>
		note
			example: "[
			/* Title Strip */
			#banner-inner {
				border-top: 1px solid #ddd;
				border-bottom: 1px solid #ddd;
				margin: 0;
				padding: 0;
				position: absolute;
				top: 22px;
				width: 1000px;
				background: rgb(255, 255, 255) transparent; /* Fallback Solid Color */
				background: rgba(255, 255, 255, 0.6); /* Opacity */
				/* IE */ filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99FFFFFF,endColorstr=#99FFFFFF);
				zoom: 1;
				}
		]"
		local
			l_rule: BEM_RULE
		do
			create l_rule.make_selectors_space_delimited (<<
				create {CSS_DECLARATION}.make_unquoted_value (border_top_kw, border_size_top.out + "px " + solid_setting + " #" + border_color_top),
				create {CSS_DECLARATION}.make_unquoted_value (border_bottom_kw, border_size_bottom.out + "px " + solid_setting + " #" + border_color_bottom),
				create {CSS_DECLARATION}.make_unquoted_value (margin_kw, margin.out),
				create {CSS_DECLARATION}.make_unquoted_value (padding_kw, padding.out),
				create {CSS_DECLARATION}.make_unquoted_value (position_kw, absolute_kw),
				create {CSS_DECLARATION}.make_uom_value (top_kw, top.out, px_uom_kw),
				create {CSS_DECLARATION}.make_uom_value (width_kw, width.out, px_uom_kw),
				create {CSS_DECLARATION}.make_unquoted_value (background_kw, background_color + " " + background_transparent_setting),
				create {CSS_DECLARATION}.make_unquoted_value (background_kw, background_opacity_alpha_channel_color),
				create {CSS_DECLARATION}.make_unquoted_value (zoom_kw, zoom.out)
				>>)
			set_rule (l_rule)
		end

feature -- Background Color

	background_color: STRING attribute Result := background_color_default.twin end
	background_color_default: STRING = "rgb(255, 255, 255)"
	set_background_color (a_value: like background_color) do background_color := a_value ensure background_color ~ a_value end

feature -- Background Opacity

	background_opacity_alpha_channel_color: STRING attribute Result := background_opacity_alpha_channel_color_default.twin end
	background_opacity_alpha_channel_color_default: STRING = "rgba(255, 255, 255, 0.6)"
	set_background_opacity_alpha_channel_color (a_value: like background_opacity_alpha_channel_color) do background_opacity_alpha_channel_color := a_value ensure background_opacity_alpha_channel_color ~ a_value end

feature -- Solid Setting

	is_solid: BOOLEAN attribute Result := False end
	set_solid do set_is_solid (True) ensure is_solid end
	reset_solid do set_is_solid (False) ensure not is_solid end
	set_is_solid (a_value: like is_solid) do is_solid := a_value ensure is_solid ~ a_value end
	solid_setting: like solid_kw
		do
			if is_solid then
				Result := solid_kw.twin
			else
				create Result.make_empty
			end
		ensure
			valid: is_solid implies Result ~ solid_kw
		end

feature -- Background Transparency

	is_background_transparent: BOOLEAN attribute Result := False end
	set_background_transparent do set_is_background_transparent (True) ensure set: is_background_transparent end
	reset_background_transparent do set_is_background_transparent (False) ensure reset: not is_background_transparent end
	set_is_background_transparent (a_value: like is_background_transparent) do is_background_transparent := a_value ensure is_background_transparent ~ a_value end
	background_transparent_setting: like transparent_kw
		do
			if is_background_transparent then
				Result := transparent_kw.twin
			else
				create Result.make_empty
			end
		end

feature -- Borders

	border_size_top: INTEGER
	set_border_size_top (a_value: like border_size_top) do border_size_top := a_value ensure border_size_top ~ a_value end

	border_color_top: STRING attribute Result := border_color_top_default.twin end
	border_color_top_default: STRING = "ddd"
	set_border_color_top (a_value: like border_color_top) do border_color_top := a_value ensure border_color_top ~ a_value end

	border_color_bottom: STRING attribute Result := border_color_bottom_default.twin end
	border_color_bottom_default: STRING = "ddd"
	set_border_color_bottom (a_value: like border_color_bottom) do border_color_bottom := a_value ensure border_color_bottom ~ a_value end

	border_size_bottom: INTEGER
	set_border_size_bottom (a_value: like border_size_bottom) do border_size_bottom := a_value ensure border_size_bottom ~ a_value end

	border_top: STRING attribute Result := border_top_default.twin end
	border_top_default: STRING = ""
	set_border_top (a_value: like border_top) do border_top := a_value ensure border_top ~ a_value end

	border_bottom: STRING attribute Result := "<<SET_BORDER_BOTTOM>>" end
	set_border_bottom (a_value: like border_bottom) do border_bottom := a_value ensure border_bottom ~ a_value end

feature -- Miscellaneous

	is_transparent: BOOLEAN attribute Result := False end
	set_is_transparent (a_value: like is_transparent) do is_transparent := a_value ensure is_transparent ~ a_value end

	position: STRING attribute Result := "<<SET_POSITION>>" end
	set_position (a_value: like position) do position := a_value ensure position ~ a_value end

	top: INTEGER
	set_top (a_value: like top) do top := a_value ensure top ~ a_value end

	width: INTEGER
	set_width (a_value: like width) do width := a_value ensure width ~ a_value end

	zoom: INTEGER
	set_zoom (a_value: like zoom) do zoom := a_value ensure zoom ~ a_value end

;note
	example: "[
	/* Title Strip */
	#banner-inner {
		border-top: 1px solid #ddd;
		border-bottom: 1px solid #ddd;
		margin: 0;
		padding: 0;
		position: absolute;
		top: 22px;
		width: 1000px;
		background: rgb(255, 255, 255) transparent; /* Fallback Solid Color */
		background: rgba(255, 255, 255, 0.6); /* Opacity */
		/* IE */ filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99FFFFFF,endColorstr=#99FFFFFF);
		zoom: 1;
		}
]"

end
