; extends
((script_element
   (start_tag
     (attribute
       (attribute_name) @attr_name (#eq? @attr_name "type")
       (quoted_attribute_value
         (attribute_value) @type (#eq? @type "text/babel"))))
   (raw_text) @injection.content)
 (#set! injection.language "tsx"))
