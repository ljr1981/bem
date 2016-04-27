note
	description: "Tests of {BEM}."
	testing: "type/manual"

class
	BEM_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	bem_tests
			-- `bem_tests'
		note
			EIS: "src=http://getbem.com/introduction/"
			EIS: "src=http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/"
		local
			l_docs: BEM_DOCS
			l_block: BEM_BLOCK
			l_element: BEM_ELEMENT
			l_modifier: BEM_MODIFIER
		do
			create l_element.make ("female", Void)
			create l_modifier.make ("hand", Void)
			create l_block.make ("person", <<l_element, l_modifier>>)
			assert_strings_equal ("person_female_hand1", "person__female--hand", l_block.out)

			create l_block.make_with_element_and_modifier ("person", "female", "hand")
			assert_strings_equal ("person_female_hand2", "person__female--hand", l_block.out)

			create l_block.make_with_element ("person", "female")
			assert_strings_equal ("person_female", "person__female", l_block.out)

			create l_block.make_with_modifier ("person", "hand")
			assert_strings_equal ("person_hand", "person--hand", l_block.out)

		end

end
