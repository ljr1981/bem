note
	description: "[
		Representation of a {BEM_BLOCK}.
		]"
	design: "[
		See notes at the end of this class.
		]"

class
	BEM_BLOCK

inherit
	BEM_ANY
		redefine
			out
		end

create
	default_create,
	make,
	make_with_element,
	make_with_modifier,
	make_with_element_and_modifier

feature {NONE} -- Initialization

	make_with_element (a_name, a_element: like name)
			-- `make_with_element' using `a_name' and `a_element'.
		require
			has_name: not a_name.is_empty
			has_element: not a_element.is_empty
		do
			make (a_name, <<create {BEM_ELEMENT}.make (a_element, Void)>>)
		end

	make_with_modifier (a_name, a_modifier: like name)
			-- `make_with_modifer' using `a_name' and `a_element'.
		require
			has_name: not a_name.is_empty
			has_modifier: not a_modifier.is_empty
		do
			make (a_name, <<create {BEM_MODIFIER}.make (a_modifier, Void)>>)
		end

	make_with_element_and_modifier (a_name, a_element, a_modifier: like name)
			-- `make_with_element_and_modifier' using `a_name', `a_element', and `a_modifier'.
		require
			has_name: not a_name.is_empty
			has_element: not a_element.is_empty
			has_modifier: not a_modifier.is_empty
		do
			make (a_name, <<create {BEM_ELEMENT}.make (a_element, Void), create {BEM_MODIFIER}.make (a_modifier, Void)>>)
		end

	make (a_name: like name; a_parts: detachable ARRAY [BEM_BLOCK])
			-- `make' Current with `a_name' and `a_parts'.
		do
			name := a_name
			if attached a_parts as al_parts then
				across al_parts as ic loop parts.force (ic.item) end
			end
		ensure
			name_set: name.same_string (a_name)
			parts: attached a_parts as al_parts implies
					across al_parts as ic all parts.has (ic.item) end
		end

feature -- Access

	name: STRING
			-- `name' of Current {BEM_BLOCK}.
		attribute
			create Result.make_empty
		end

	parts: ARRAYED_LIST [BEM_BLOCK]
			-- `parts' of Current {BEM_BLOCK}.
		attribute
			create Result.make (Default_capacity)
		end

	prefix_text: STRING
		once ("object")
			create Result.make_empty
		end
			-- `prefix_text' which is placed in front of Current on `out'.

	separator: CHARACTER = '-'
			-- `separator' character.

feature -- Settings

	set_name (a_name: like name)
			-- `set_name' with `a_name'.
		do
			name := a_name
		ensure
			set: name.same_string (a_name)
		end

	add_part (a_part: like Current)
			-- `add_part' `a_part' to `parts'.
		do
			parts.force (a_part)
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			create Result.make_empty
			Result.append_string (prefix_text)
			Result.append_string (name)
			across
				parts as ic_parts
			loop
				if ic_parts.item.generating_type.same_string (generating_type) then
					Result.append_character (separator)
				else
					Result.append_string (ic_parts.item.prefix_text)
				end
				Result.append_string (ic_parts.item.name)
			end
		end

feature -- Constants

	Default_capacity: INTEGER = 10

note
	design: "[
		The term "block" is (perhaps) sourced in the notion of a block-tag
		from HTML, where the notion of block was first modeled tightly to
		the HTML notion of block. However, further reading on the subject
		seems to indicate that the notion has moved on, but simply retained
		the moniker for historical reasons.
		
		A block is seen as a collector of other (optional) subordinates like
		{BEM_ELEMENT}s and {BEM_MODIFIER}s. Again, the birthplace of these
		monikers is (perhaps) to be found in HTML4 and HTML5 structures (e.g.
		table blocks have subordinate elements, the elements have semantic
		dependence upon the higher block container). The notion of modifier
		is the only notion that seems not be directly equal to some HTML thing.
		
		Nevertheless--A {BEM_BLOCK} can contain one or more subordinate items,
		which are applied in an arbitrary order.
		
		Moreover--A {BEM_BLOCK} can be "out"d (output) into a formatted string
		following a very loose "best-practice" naming convention, where:
		
		{BEM_ELEMENT} items are output as __[Element_name]
		
		{BEM_MODIFIER} items are output as --[Modifier_name]
		
		The elements and modifiers can be to any depth, but shallow is preferred
		over deep (to aid with readability).
		
		{BEM_BLOCK}s (as well as elements and modifiers) can be grouped together.
		When that happens, the items are hyphenated between them. For example:
		site and then site-search as a notion of general-to-specific block.
		]"

end
