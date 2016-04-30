note
	description: "[
		Representation of a {CSS_RULE} wrapper as {BEM_RULE}
		]"

class
	BEM_RULE

inherit
	BEM_ANY
		undefine
			out
		end

create
	make_inclusive,
	make_separate

feature {NONE} -- Initialization

	make_inclusive (a_declarations: ARRAY [CSS_DECLARATION])
			-- `make_inclusive' with `a_declarations'.
		do
			create internal_css_rule.make_inclusive (<<>>, a_declarations)
		end

	make_separate (a_declarations: ARRAY [CSS_DECLARATION])
			-- `make_separate' with `a_declarations'.
		do
			create internal_css_rule.make_separate (<<>>, a_declarations)
		end

feature -- Access

	out: like internal_css_rule.out
		do
			Result := internal_css_rule.out
		end

	rules: like internal_css_rule.rules
		do
			Result := internal_css_rule.rules
		end

	css_rule: like internal_css_rule
			-- `css_rule' is the complete {CSS_RULE}.
		do
			Result := internal_css_rule
		end

feature -- Settings

	set_inclusive
			-- `set_inclusive' like `internal_css_rule'.
		do
			internal_css_rule.set_inclusive
		end

	set_separate
			-- `set_separate' like `internal_css_rule'.
		do
			internal_css_rule.set_separate
		end

	add_rule (a_rule: like internal_css_rule)
		do
			internal_css_rule.add_sub_rule (a_rule)
		end

	add_class_selector (a_name: STRING)
			-- `add_class_selector' using `a_name' to `class_rule'.
		do
			internal_css_rule.add_class_selector (a_name)
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
		]"

end
