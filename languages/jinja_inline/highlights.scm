; We consider everything "preprocessor" since that's the closest existing capture to what a jinja block is.
; Everything is suffixed with "preproc." in order to allow the user to highlight them all together as a whole,
; or highlight captures separately, as desired.

; Captures:
; @preproc                          - default
; @preproc.string                   - strings
; @preproc.number.[float.]          - numbers
; @preproc.boolean                  - booleans
; @preproc.comment                  - comments
; @preproc.punctuation.delimiter    - ",.:"
; @preproc.punctuation.bracket      - "()[]<>"
; @preproc.variable                 - all variables/parameters
; @preproc.function                 - functions
; @preproc.keyword                  - all keywords/builtins
; @preproc.keyword.directive        - "{{", "}}", and other block delimiters

(_) @preproc

(string_literal) @preproc.string
(number_literal) @preproc.number
(float_literal) @preproc.number.float
(boolean_literal) @preproc.boolean
(comment) @preproc.comment

[ "," "." ":"] @preproc.punctuation.delimiter
[ "(" ")" "[" "]" "<" ">"] @preproc.punctuation.bracket

(import_statement (identifier) @preproc.variable)
(import_as (identifier) @preproc.variable)
(arg (identifier) @preproc.variable)
(expression "." (expression)+ @preproc.variable)
(assignment_expression "." (identifier)+ @preproc.variable)
(arg
  (expression
    (binary_expression
      (unary_expression
        (primary_expression
          (identifier) @preproc.variable)))))

(function_call (identifier) @preproc.function)

[
  "block" "with" "filter" "macro" "set" "trans" "pluralize" "autoescape" "endtrans" "endblock" "endwith" "endfilter"
  "endmacro" "endcall" "endset" "endtrans" "endautoescape" "include" "import" "from" "extends" "as" "if" "else" "endif"
  "elif" "for" "in" "continue" "break" "endfor" "call" "defined" "debug" "_" "recursive"
] @preproc.keyword

(builtin_test
  [
    "boolean" "even" "in" "mapping" "sequence" "callable" "integer" "ne" "string" "defined" "filter" "iterable" "none"
    "test" "divisibleby" "float" "le" "number" "eq" "ge" "lower" "odd" "undefined" "escaped" "gt" "lt" "sameas" "upper"
  ] @preproc.keyword)

[
  (attribute_ignore)
  (attribute_context)
  (null_literal)
  (binary_operator)
] @preproc.keyword

(do_statement "do" @preproc.keyword)

[
  "# "
  "{{"
  "{{-"
  "{{+"
  "+}}"
  "-}}"
  "}}"
  "{%"
  "{%-"
  "{%+"
  "+%}"
  "-%}"
  "%}"
] @preproc.keyword.directive
