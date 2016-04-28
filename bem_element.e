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
	make

feature -- Access

	prefix_text: STRING
			-- <Precursor>
			-- Using `element_prefix_text'
		once ("object")
			Result := element_prefix_text
		end

note
	design: "[

		]"

end
