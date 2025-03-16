((jinja) @content
  (#set! "language" "Jinja-Inline"))

(script_element
  (raw_text) @content
  (#set! "language" "javascript"))

(style_element
  (raw_text) @content
  (#set! "language" "css"))
