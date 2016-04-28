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
	make

feature -- Access

	prefix_text: STRING
			-- <Precursor>
			-- Using `modifier_prefix_text'
		once ("object")
			Result := modifier_prefix_text
		end

note
	design: "[

		]"

end
