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

	bem_from_text_test
			-- `bem_from_text_test'.
		note
			design: "[
				Complete testing of the `make_with_bem_text' creation procedure.
				(1) Create with BEM and then test that each item was created.
				(2) Create with BE and then test that name and element were created. (no modifier)
				(3) Create with BM and then test that name and modifier were created. (no element)
				]"
		local
			l_block: BEM_BLOCK
		do
			create l_block.make_with_bem_text ("person__female--hand")
			assert_strings_equal ("name", "person", l_block.name)
			check has_element: attached l_block.element as al_element then
				assert_strings_equal ("element", "female", al_element.name)
			end
			check has_modifier: attached l_block.modifier as al_modifier then
				assert_strings_equal ("element", "hand", al_modifier.name)
			end

			create l_block.make_with_bem_text ("person__female")
			assert_strings_equal ("name", "person", l_block.name)
			check has_element: attached l_block.element as al_element then
				assert_strings_equal ("element", "female", al_element.name)
			end
			check no_modifier: not attached l_block.modifier end

			create l_block.make_with_bem_text ("person--hand")
			assert_strings_equal ("name", "person", l_block.name)
			check has_modifier: attached l_block.modifier as al_modifier then
				assert_strings_equal ("element", "hand", al_modifier.name)
			end
			check no_element: not attached l_block.element end
		end

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
			create l_element.make ("female")
			create l_modifier.make ("hand")

			create l_block.make_with_element_and_modifier ("person", "female", "hand")
			assert_strings_equal ("person_female_hand2", "person__female--hand", l_block.out)

			create l_block.make_with_element ("person", "female")
			assert_strings_equal ("person_female", "person__female", l_block.out)

			create l_block.make_with_modifier ("person", "hand")
			assert_strings_equal ("person_hand", "person--hand", l_block.out)
		end

end
