note
	description: "[
		Representation of a {BEM_THEME} prototype.
		]"
	design: "[
		See notes at the end of this class.
		]"

class
	BEM_THEME

create
	default_create,
	make_with_blocks

feature {NONE} -- Initialization

	make_with_blocks (a_blocks: ARRAY [attached like blocks_anchor])
			-- `make_with_blocks' in `a_blocks'.
		do
			across
				a_blocks as ic_blocks
			loop
				blocks.force (ic_blocks.item)
			end
		ensure
			has_blocks: across a_blocks as ic_blocks all blocks.has (ic_blocks.item) end
		end

feature -- Access

	blocks: ARRAYED_LIST [attached like blocks_anchor]
			-- `blocks' of {BEM_BLOCK} things for Current {BEM_THEME}.
		attribute
			create Result.make (100)
		end

feature -- Settings

	add_block (a_block: attached like blocks_anchor)
			-- `add_block' in `a_block' to `blocks'.
		do
			blocks.force (a_block)
		ensure
			has: blocks.has (a_block)
		end

feature -- Outputs

	rules_out: STRING
			-- Combined `rules_out' of `blocks'.
		do
			create Result.make_empty
			across
				blocks as ic_blocks
			loop
				Result.append_string (ic_blocks.item.rule.out)
				Result.append_character ('%N')
			end
		end

feature {NONE} -- Implementation: Anchors

	blocks_anchor: detachable BEM_BLOCK
			-- `blocks_anchor'.

;note
	design: "[
		This class is intended to represent a collection of {BEM_RULE}s as
		a "Theme" (when taken together).
		]"

end
