note
	description: "[
		Representation of a {CSS_RULE} wrapper as {BEM_RULE}
		]"
	design: "[
		See notes at the end of the class.
		]"

class
	BEM_RULE

inherit
	BEM_ANY
		undefine
			out
		end

	CSS_RULE_ACCESSOR
		undefine
			default_create,
			out
		end

	CSS_CONSTANTS
		undefine
			default_create,
			out
		end

create
	make_selectors_comma_delimited,
	make_selectors_space_delimited

feature {NONE} -- Initialization

	make_selectors_comma_delimited (a_declarations: ARRAY [CSS_DECLARATION])
			-- `make_selectors_comma_delimited' with `a_declarations'.
			-- Comma-delimited selectors have the `rules' applied in a mutually
			-- exclusive way.
			-- Example: .Main, table, p <-- Any <tag> with a class="Main" and all
			--	<table> and all <p> tags will have the `rules' applied separately.
		do
			create internal_css_rule.make_selectors_comma_delimited (<<>>, a_declarations)
		end

	make_selectors_space_delimited (a_declarations: ARRAY [CSS_DECLARATION])
			-- `make_selectors_space_delimited' with `a_declarations'.
			-- Space-delimited selectors means the rules are applied in a
			-- dependent, inclusive, and tag-enclosed manner.
			-- Example: .Main table p <-- All paragraphs within tables in .Main
			--	class-named <tags> will have the `rules' applied.
		do
			create internal_css_rule.make_with_selectors_space_delimited (<<>>, a_declarations)
		end

feature -- Access

	rules: like internal_css_rule.rules
			-- A list of `rules' used by Current.
		do
			Result := internal_css_rule.rules
		end

	css_rule: like internal_css_rule
			-- `css_rule' is the complete {CSS_RULE}.
		do
			Result := internal_css_rule
		end

	is_class_based: BOOLEAN
			-- `is_class_based'?
		do
			Result := not is_tag_based and not is_id_based
		end

	is_tag_based: BOOLEAN
			-- `is_tag_based'?
			-- Usually, BEM is about .Class, but we need a
			-- way to specify that the {BEM_RULE} is based
			-- on and output as a <tag> (e.g. tag like 'form').

	is_id_based: BOOLEAN
			-- `is_id_based'?
			-- Like `is_tag_based', we need a way to specify
			-- that this {BEM_RULE} is based on and output as
			-- a #Unique_id rather than as a .Class selector.

feature -- Settings

	set_is_class_based
			-- `set_is_class_based' resets `is_tag_based' and `is_id_based' to False.
		do
			is_tag_based := False
			is_id_based := False
		ensure
			is_class_based and not is_tag_based and not is_id_based
		end

	set_is_tag_based
			-- `set_is_tag_based' on `is_tag_based', resetting `is_id_based'.
		do
			is_tag_based := True
			is_id_based := False
		ensure
			is_tag_based and not is_id_based and not is_class_based
		end

	set_is_id_based
			-- `set_is_tag_based' on `is_id_based', resetting `is_tag_based'.
		do
			is_id_based := True
			is_tag_based := False
		ensure
			is_id_based and not is_tag_based and not is_class_based
		end

	set_selectors_space_delimited
			-- `set_selectors_space_delimited' like `internal_css_rule'.
			-- Example: .Main table p <-- all table-based paragraphs in
			-- 	HTML tags with the class-name of "Main".
		do
			internal_css_rule.set_selectors_to_space_delimited
		end

	set_selectors_comma_delimited
			-- `set_selectors_comma_delimited' like `internal_css_rule'.
			-- Example: .Main, table, p <-- All HTML tags with the class-name
			--	of "Main" and all <table> and all <p>, independent of each other.
		do
			internal_css_rule.set_selectors_to_comma_delimited
		end

	add_rule (a_rule: like internal_css_rule)
			-- Add `a_rule' as a subordinate internal rule.
			-- This is where SASS and OOCSS come into play.
		do
			internal_css_rule.add_sub_rule (a_rule)
		end

	add_class_selector (a_name: STRING)
			-- `add_class_selector' using `a_name' to `class_rule'.
			-- Add a class-based selector with `a_name' to the
			-- internal CSS rule.
		do
			internal_css_rule.add_class_selector (a_name)
		end

	add_tag_selector (a_name: STRING)
			-- `add_tag_selector' using `a_name' to `class_rule'.
			-- Add a tag-based selector with `a_name' to the
			-- internal CSS rule.
		do
			internal_css_rule.add_tag_selector (a_name)
		end

	add_id_selector (a_name: STRING)
			-- `add_id_selector' using `a_name' to `class_rule'.
			-- Add a id-based selector with `a_name' to the
			-- internal CSS rule.
		do
			internal_css_rule.add_id_selector (a_name)
		end

feature -- Output

	selectors_out: STRING
		do
			Result := internal_css_rule.selectors_out (space_character)
		end

	out: like internal_css_rule.out
			-- Render Current to well-formed CSS.
		do
			Result := internal_css_rule.out
		end

feature {NONE} -- Implementation: {CSS_RULE}

	internal_css_rule: CSS_RULE
			-- `internal_css_rule'.

;note
	design: "[
		A {BEM_RULE} is a form of {CSS_RULE}, but stripped of the capacity
		to have its selectors specified from the outside-in. Selectors are
		the responsibility of a host {BEM_BLOCK}, where the selector is
		computed from the notion of a BEM Block.
		
		Example: Block__Element--Modifier
		]"

end
