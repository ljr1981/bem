note
	description: "[
		Representation of a {BEM} class.
		]"

class
	BEM

feature -- Constants

	element_prefix_text: STRING = "__"
	modifier_prefix_text: STRING = "--"
	common_split_delimiter: CHARACTER = '|'

--	inquotes,quoted: BOOLEAN = True
--	noquotes,unquoted: BOOLEAN = False

end
