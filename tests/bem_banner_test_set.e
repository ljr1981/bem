note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	BEM_BANNER_TEST_SET

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

feature -- Testing: BEM_BANNER_THEME

	bem_banner_theme_test
			-- `bem_banner_theme_test'
		local
			l_item: BEM_BANNER_THEME
		do
			create l_item

			l_item.banner_container.set_banner_url ("moonshot.png")
			l_item.banner_container.set_center

			l_item.banner_title_strip.set_border_size_top (1)
			l_item.banner_title_strip.set_solid
			l_item.banner_title_strip.set_border_size_bottom (1)
			l_item.banner_title_strip.set_background_transparent
			l_item.banner_title_strip.set_zoom (1)

			assert_strings_equal ("bem_banner_theme", bem_banner_theme, l_item.item.rules_out)
		end

feature {NONE} -- Testing: {BEM_BANNER_CONTAINER} Support

	bem_banner_theme: STRING = "[
.banner__container {background:#f5f5f5 url(moonshot.png) no-repeat center;height:180px;margin:0;padding:0;}
.banner__title_strip {border-top:1px solid #ddd;border-bottom:1px solid #ddd;margin:0;padding:0;position:absolute;top:0px;width:0px;background:rgb(255, 255, 255) transparent;background:rgba(255, 255, 255, 0.6);zoom:1;}

]"

feature -- Testing: {BEM_BANNER_CONTAINER}

	bem_banner_container_test
			-- `bem_banner_container_test'
		local
			l_item: BEM_BANNER_CONTAINER
		do
			create l_item
			l_item.generate
			assert_strings_equal ("banner_container_rule_default", banner_container_rule_default, l_item.rule.out)
			l_item.set_banner_url ("moonshot.png")
			l_item.set_center
			l_item.generate
			assert_strings_equal ("banner_container_rule_with_settings", banner_container_rule_with_settings, l_item.rule.out)
		end

feature {NONE} -- Testing: {BEM_BANNER_CONTAINER} Support

	banner_container_rule_default: STRING = ".banner__container {background:#f5f5f5 url(<<SET_ME>>) no-repeat right;height:180px;margin:0;padding:0;}"
	banner_container_rule_with_settings: STRING = ".banner__container {background:#f5f5f5 url(moonshot.png) no-repeat center;height:180px;margin:0;padding:0;}"

feature -- Testing: {BEM_BANNER_TITLE_STRIP}

	bem_banner_title_strip_test
			-- `bem_banner_title_strip_test'
		local
			l_item: BEM_BANNER_TITLE_STRIP
		do
			create l_item
			l_item.generate
			assert_strings_equal ("banner_title_string_rule_default", banner_title_string_rule_default, l_item.rule.out)
			l_item.set_border_size_top (1)
			l_item.set_is_solid (True)
			l_item.set_border_size_bottom (1)
			l_item.set_is_background_transparent (True)
			l_item.set_zoom (1)
			l_item.generate
			assert_strings_equal ("banner_title_string_rule", banner_title_string_rule, l_item.rule.out)
		end

feature {NONE} -- Testing: {BEM_BANNER_TITLE_STRIP} Support

	banner_title_string_rule_default: STRING = ".banner__title_strip {border-top:0px  #ddd;border-bottom:0px  #ddd;margin:0;padding:0;position:absolute;top:0px;width:0px;background:rgb(255, 255, 255) ;background:rgba(255, 255, 255, 0.6);zoom:0;}"
	banner_title_string_rule: STRING = ".banner__title_strip {border-top:1px solid #ddd;border-bottom:1px solid #ddd;margin:0;padding:0;position:absolute;top:0px;width:0px;background:rgb(255, 255, 255) transparent;background:rgba(255, 255, 255, 0.6);zoom:1;}"

end


