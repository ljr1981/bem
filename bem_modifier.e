note
	description: "[
		Representation of a {BEM_MODIFIER}.
		]"
	design: "[
		See notes at the end of this class.
		]"

class
	BEM_MODIFIER

inherit
	BEM_BLOCK
		redefine
			prefix_text
		end

create
	default_create,
	make

feature -- Access

	prefix_text: STRING
			-- <Precursor>
		once ("object")
			Result := "--"
		end

note
	design: "[

		]"

end
