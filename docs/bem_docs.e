note
	description: "[
		Representation of {BEM_DOCS} class documentation.
		]"

class
	BEM_DOCS

note
	EIS: "src=http://getbem.com/introduction/"
	EIS: "src=http://www.slideshare.net/MaxShirshin/bem-it-for-brandwatch"
	EIS: "src=http://stackoverflow.com/questions/27894664/how-to-properly-set-an-elements-scope-using-bem"
	definition: "[
		What is "BEM"?
		==============
		
		Block Element Modifier
		----------------------		
		Block: 		Standalone entity that is meaningful on its own.
					Represents the higher level of an abstraction or component.
					
						(Example: header, container, menu, checkbox, input)
						
		Element: 	Parts of a block and have no standalone meaning but semantically related.
					Represents a descendent (as in "contained in") of .block 
						that helps form .block as a whole.
						
						(Example: menu item, list item, checkbox caption, header title)
						
		Modifer: 	Flags on blocks or elements. Use them to change	appearance or behavior.
					Represents a different state or version of .block.
						
						(Example: disabled, highlighted, checked, fixed, size big, color yellow)
						
		See EIS below.
		]"
	EIS: "src=http://getbem.com/introduction/"
	EIS: "src=http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/"
	design: "[
		BEM is a facilitator of OOCSS (Object Oriented CSS).
		]"

end
