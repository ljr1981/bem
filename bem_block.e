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

	BEM_CONSTANTS
		undefine
			out
		end

create
	make,
	make_with_element,
	make_with_modifier,
	make_with_element_and_modifier,
	make_with_bem_text,
	make_class_based,
	make_tag_based,
	make_id_based

feature {NONE} -- Initialization

	make_with_element (a_name, a_element: like name)
			-- `make_with_element' using `a_name' and `a_element'.
		require
			has_name: not a_name.is_empty
			has_element: not a_element.is_empty
		do
			make (a_name)
			element := create {BEM_ELEMENT}.make (a_element)
		end

	make_with_modifier (a_name, a_modifier: like name)
			-- `make_with_modifer' using `a_name' and `a_element'.
		require
			has_name: not a_name.is_empty
			has_modifier: not a_modifier.is_empty
		do
			make (a_name)
			modifier := create {BEM_MODIFIER}.make (a_modifier)
		end

	make_with_element_and_modifier (a_name, a_element, a_modifier: like name)
			-- `make_with_element_and_modifier' using `a_name', `a_element', and `a_modifier'.
		require
			has_name: not a_name.is_empty
			has_element: not a_element.is_empty
			has_modifier: not a_modifier.is_empty
		do
			make (a_name)
			element := create {BEM_ELEMENT}.make (a_element)
			modifier := create {BEM_MODIFIER}.make (a_modifier)
		end

	make (a_name: like name)
			-- `make' Current with `a_name' and `a_parts'.
		do
			name := a_name
		ensure
			name_set: name.same_string (a_name)
		end

	make_class_based (a_tag_name: like name; a_rule: BEM_RULE)
			-- `make_tag_based' using `a_tag_name'.
		do
			make (a_tag_name)
			set_rule (a_rule)
			if attached internal_rule as al_rule then
				al_rule.set_is_class_based
			end
		end

	make_tag_based (a_tag_name: like name; a_rule: BEM_RULE)
			-- `make_tag_based' using `a_tag_name'.
		do
			make (a_tag_name)
			set_rule (a_rule)
			if attached internal_rule as al_rule then
				al_rule.add_tag_selector (a_tag_name)
				al_rule.set_is_tag_based
			end
		end

	make_id_based (a_unique_identifier: like name; a_rule: BEM_RULE)
			-- `make_tag_based' using `a_unique_identifier'.
		do
			make (a_unique_identifier)
			set_rule (a_rule)
			if attached internal_rule as al_rule then
				al_rule.add_id_selector (a_unique_identifier)
				al_rule.set_is_id_based
			end
		end

	make_with_bem_text (a_bem_text: STRING)
			-- `make_with_bem_text' of `a_bem_text'.
		do
			if a_bem_text.has_substring (element_prefix_text) and a_bem_text.has_substring (modifier_prefix_text) then
				split_block_element_modifier (a_bem_text)
			elseif a_bem_text.has_substring (element_prefix_text) then
				split_block_element (a_bem_text)
			elseif a_bem_text.has_substring (modifier_prefix_text) then
				split_block_modifier (a_bem_text)
			else
				create name.make_empty
				check False end
			end
		end

feature {NONE} -- Initialization: Support

	split_block_element_modifier (a_bem_text: STRING)
			-- `split_block_element_modifier' on `a_bem_text'.
		require
			both: a_bem_text.has_substring (element_prefix_text) and then
					a_bem_text.has_substring (modifier_prefix_text)
		local
			l_text: STRING
			l_list: LIST [STRING]
		do
			l_text := a_bem_text.twin
			l_text.replace_substring_all (element_prefix_text, common_split_delimiter.out)
			l_text.replace_substring_all (modifier_prefix_text, common_split_delimiter.out)
			l_list := l_text.split (common_split_delimiter)
			check bem_count: l_list.count = 3 end
			name := l_list [1]
			create element.make (l_list [2])
			create modifier.make (l_list [3])
		end

	split_block_element (a_bem_text: STRING)
			-- `split_block_element' on `a_bem_text'.
		require
			no_modifier: not a_bem_text.has_substring (modifier_prefix_text)
		local
			l_text: STRING
			l_list: LIST [STRING]
		do
			l_text := a_bem_text.twin
			l_text.replace_substring_all (element_prefix_text, common_split_delimiter.out)
			l_list := l_text.split (common_split_delimiter)
			check bem_count: l_list.count = 2 end
			name := l_list [1]
			create element.make (l_list [2])
		end

	split_block_modifier (a_bem_text: STRING)
			-- `split_block_modifier' on `a_bem_text'.
		require
			no_element: not a_bem_text.has_substring (element_prefix_text)
		local
			l_text: STRING
			l_list: LIST [STRING]
		do
			l_text := a_bem_text.twin
			l_text.replace_substring_all (modifier_prefix_text, common_split_delimiter.out)
			l_list := l_text.split (common_split_delimiter)
			check bem_count: l_list.count = 2 end
			name := l_list [1]
			create modifier.make (l_list [2])
		end

feature -- Access

	name: STRING
			-- `name' of Current {BEM_BLOCK}.

	element: detachable BEM_ELEMENT
			-- Optional `element' of Current {BEM_BLOCK}.

	modifier: detachable BEM_MODIFIER
			-- Optional `modifier' of Current {BEM_BLOCK}.

	rule: attached like internal_rule
			-- `rule' of Current {BEM_BLOCK}.
		do
			check has_rule: attached internal_rule as al_rule then
				Result := al_rule
				if al_rule.is_class_based then
					Result.add_class_selector (out)
				elseif al_rule.is_tag_based then
					Result.add_tag_selector (out)
				elseif al_rule.is_id_based then
					Result.add_id_selector (out)
				end
			end
		end

feature {NONE} -- Implementation: Access

	internal_rule: detachable BEM_RULE
			-- Optional `internal_rule' for Current {BEM_BLOCK}.

feature -- Settings

	set_name (a_name: like name)
			-- `set_name' with `a_name'.
		do
			name := a_name
		ensure
			set: name.same_string (a_name)
		end

	set_element (a_element: attached like element)
			-- `set_element' with `a_element'.
		do
			element := a_element
		ensure
			set: attached element as al_element and then al_element ~ a_element
		end

	set_modifier (a_modifier: attached like modifier)
			-- `set_element' with `a_modifier'.
		do
			modifier := a_modifier
		ensure
			set: attached modifier as al_modifier and then al_modifier ~ a_modifier
		end

	set_rule (a_rule: attached like internal_rule)
			-- `set_rule' `a_rule' into `internal_rule'.
		do
			internal_rule := a_rule
		ensure
			set: attached internal_rule as al_rule and then al_rule ~ a_rule
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			create Result.make_empty
			if attached internal_rule as al_rule then
				if al_rule.is_class_based then
					Result.append_string (prefix_text)
					Result.append_string (name)
					if attached element as al_element then
						Result.append_string (al_element.prefix_text)
						Result.append_string (al_element.name)
					end
					if attached modifier as al_modifier then
						Result.append_string (al_modifier.prefix_text)
						Result.append_string (al_modifier.name)
					end
				else
					--Result.append (al_rule.selectors_out)
				end
			else
				Result := "*"
			end
		end

feature -- Constants

	prefix_text: STRING
			-- `prefix_text' which is placed in front of Current on `out'.
		once ("object")
			Result := ""
		end

	separator: CHARACTER = '-'
			-- `separator' character.

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
