; Types

; Javascript

; Variables
;-----------
(identifier) @variable

; Properties
;-----------

(property_identifier) @property
(shorthand_property_identifier) @property
(private_property_identifier) @property

(variable_declarator
  name: (object_pattern
    (shorthand_property_identifier_pattern))) @variable

; Special identifiers
;--------------------

((identifier) @type
 (#lua-match? @type "^[A-Z]"))

((identifier) @constant
 (#lua-match? @constant "^_*[A-Z][A-Z%d_]*$"))

((shorthand_property_identifier) @constant
 (#lua-match? @constant "^_*[A-Z][A-Z%d_]*$"))

(lexical_declaration
  "const"
  . (variable_declarator
      . name: (identifier) @constant))

((identifier) @variable.builtin
 (#vim-match? @variable.builtin "^(arguments|module|console|window|document)$"))

((identifier) @function.builtin
 (#eq? @function.builtin "require"))

; Function and method definitions
;--------------------------------

(function
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(generator_function
  name: (identifier) @function)
(generator_function_declaration
  name: (identifier) @function)
(method_definition
  name: [(property_identifier) (private_property_identifier)] @method)

(pair
  key: (property_identifier) @method
  value: (function))
(pair
  key: (property_identifier) @method
  value: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (arrow_function))
(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (function))

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))
(variable_declarator
  name: (identifier) @function
  value: (function))

(assignment_expression
  left: (identifier) @function
  right: (arrow_function))
(assignment_expression
  left: (identifier) @function
  right: (function))

; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (member_expression
    property: [(property_identifier) (private_property_identifier)] @method.call))

; Constructor
;------------

(new_expression
  constructor: (identifier) @constructor)

; Variables
;----------
(namespace_import
  (identifier) @namespace)

; Literals
;---------

[
  (this)
  (super)
] @variable.builtin

[
  (true)
  (false)
] @boolean

[
  (null)
  (undefined)
] @constant.builtin

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

(hash_bang_line) @preproc

(string) @string @spell
(template_string) @string
(escape_sequence) @string.escape
(regex_pattern) @string.regex
(regex "/" @punctuation.bracket) ; Regex delimiters

(number) @number
((identifier) @number
  (#any-of? @number "NaN" "Infinity"))

; Punctuation
;------------

"..." @punctuation.special

";" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter

(pair ":" @punctuation.delimiter)
(pair_pattern ":" @punctuation.delimiter)

[
  "--"
  "-"
  "-="
  "&&"
  "+"
  "++"
  "+="
  "&="
  "/="
  "**="
  "<<="
  "<"
  "<="
  "<<"
  "="
  "=="
  "==="
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  "||"
  "%"
  "%="
  "*"
  "**"
  ">>>"
  "&"
  "|"
  "^"
  "??"
  "*="
  ">>="
  ">>>="
  "^="
  "|="
  "&&="
  "||="
  "??="
] @operator

(binary_expression "/" @operator)
(ternary_expression ["?" ":"] @conditional.ternary)
(unary_expression ["!" "~" "-" "+"] @operator)
(unary_expression ["delete" "void" "typeof"] @keyword.operator)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

((template_substitution ["${" "}"] @punctuation.special) @none)

; Keywords
;----------

[
  "if"
  "else"
  "switch"
  "case"
] @conditional

[
  "import"
  "from"
] @include

(export_specifier "as" @include)
(import_specifier "as" @include)
(namespace_export "as" @include)
(namespace_import "as" @include)

[
  "for"
  "of"
  "do"
  "while"
  "continue"
] @repeat

[
  "break"
  "class"
  "const"
  "debugger"
  "export"
  "extends"
  "get"
  "in"
  "instanceof"
  "let"
  "set"
  "static"
  "target"
  "typeof"
  "var"
  "with"
] @keyword

[
  "async"
  "await"
] @keyword.coroutine

[
  "return"
  "yield"
] @keyword.return

[
  "function"
] @keyword.function

[
  "new"
  "delete"
] @keyword.operator

[
  "throw"
  "try"
  "catch"
  "finally"
] @exception

(export_statement
  "default" @keyword)
(switch_default
  "default" @conditional)
