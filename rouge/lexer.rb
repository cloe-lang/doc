module Rouge
  module Lexers
    # Cloe programming language lexer
    class Cloe < RegexLexer
      title 'Cloe'
      desc 'Cloe programming language'

      tag 'cloe'

      filenames '*.cloe'

      mimetypes 'text/x-cloe', 'application/x-cloe'

      KEYWORDS = Set.new %w[def import let match mr type \\]

      BUILTINS = Set.new %w[
        and bool? catch delete dict dict? dump error eseq first function?
        if include indexOf insert ordered?
        list? map matchError max merge min mod nil? number? not
        or par partial pure rally read reduce rest
        seq size slice string? toList toString typeOf write zip
      ]

      OPERATORS = Set.new %w[+ - * / ** // = < <= > >=]

      CONSTANTS = Set.new %w[false nil true]

      TYPES = Set.new %w[any bool dict function list nil number string]

      def name(name)
        return Keyword if KEYWORDS.include?(name)
        return Keyword::Type if TYPES.include?(name)
        return Operator if OPERATORS.include?(name)
        return Name::Constant if CONSTANTS.include?(name)
        return Name::Builtin if BUILTINS.include?(name)
        Name
      end

      state :root do
        rule(/^#!.*$/, Comment)
        rule(/\s+/m, Text::Whitespace)

        rule(/;.*?$/, Comment::Single)

        rule(/-?\d+(\.\d+)?/, Num::Float)
        rule(/0x[0-9a-fA-F]+/, Num::Hex)
        rule(/"(\\.|[^"])*"/, Str)

        rule(/[()\[\]{}.]/, Punctuation)

        rule(/[^()\[\]{}".;\s]+/) do |m|
          token name(m[0])
        end
      end
    end
  end
end
