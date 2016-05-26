note
	description: "[
		Representation of an effected {BEM_BANNER_CONTAINER}.
		BEM = "banner__container" or /* Banner Container */ (see EIS below)
		]"
	EIS: "src=http://themes.typepad.com/"
	EIS: "src=http://themes.typepad.com/guide/banner/"
	EIS: "src=http://static.typepad.com/.shared/themes/typepad/theme-clean/typepad-theme-banner.css"

class
	BEM_BANNER_CONTAINER

inherit
	BEM_BANNER_ROOT
		redefine
			name
		end

feature -- Access

	name: STRING attribute Result := "banner__container" end

feature -- Basic Operations

	generate
			-- <Precursor>
		local
			l_rule: BEM_RULE
		do
			if height = 0 then
				height := default_height
			end
			create l_rule.make_selectors_space_delimited (<<
				create {CSS_DECLARATION}.make_unquoted_value (background_kw, background + " url(" + banner_url + ") " + repeat_setting + " " + justify_setting),
				create {CSS_DECLARATION}.make_uom_value (height_kw, height.out, px_uom_kw),
				create {CSS_DECLARATION}.make_unquoted_value (margin_kw, margin.out),
				create {CSS_DECLARATION}.make_unquoted_value (padding_kw, padding.out)
				>>)
			set_rule (l_rule)
		end

feature -- Setters


	banner_url: STRING attribute Result := "<<SET_ME>>" end
	set_banner_url (a_value: like banner_url) do banner_url := a_value ensure banner_url ~ a_value end

	is_repeat: BOOLEAN attribute Result := False end
	set_repeating do is_repeat := True end
	set_no_repeating do is_repeat := False end

	is_left: BOOLEAN attribute Result := False end
	set_left 	do is_left := True; is_center := False; is_right := False end

	is_center: BOOLEAN attribute Result := True end
	set_center 	do is_left := False; is_center := True; is_right := False end

	is_right: BOOLEAN attribute Result := False end
	set_right 	do is_left := False; is_center := False; is_right := True end

	height: INTEGER
	set_height (a_value: like height) do height := a_value ensure height ~ a_value end

	default_height: INTEGER = 180

feature {NONE} -- Implementation: Generators

	repeat_setting: STRING
		do
			create Result.make_empty
			if not is_repeat then
				Result.append_string ("no-repeat")
			end
		end

	justify_setting: STRING
		do
			if is_left then
				Result := left_kw
			elseif is_center then
				Result := center_kw
			else
				Result := right_kw
			end
		end

note
	design_intent: "[
		Handles the notion of a "banner__container" (BEM).
		]"
	example: "[
/* Banner Container */ 
#banner {
	background: #f5f5f5 url(banner.jpg) no-repeat center;
	height: 180px;
	margin: 0;
	padding: 0;
	}
]"

end
