note
	description: "[
		Representation of a {BEM_ELEMENT}.
		]"
	design: "[
		See notes at the end of this class.
		]"

class
	BEM_ELEMENT

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
			Result := "__"
		end

note
	design: "[

		]"

end
