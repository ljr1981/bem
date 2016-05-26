note
	description: "[
		Representation of an effected {BEM_BANNER_THEME}.
		]"

class
	BEM_BANNER_THEME

feature -- Access

	item: BEM_THEME
			-- `item' of Current.
		do
			banner_container.generate
			banner_title_strip.generate
			
			create Result.make_with_blocks (<<
						banner_container,
						banner_title_strip>>)
		end


	banner_container: BEM_BANNER_CONTAINER
		attribute
			create Result
		end

	banner_title_strip: BEM_BANNER_TITLE_STRIP
		attribute
			create Result
		end


note
	design_intent: "[
		Your_text_goes_here
		]"

end
