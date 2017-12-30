module Rouge
  module Lexers
    # Coel programming language lexer
    class Coel < RegexLexer
      title 'Coel'
      desc 'Coel programming language'

      tag 'coel'

      filenames '*.coel'

      mimetypes 'text/x-coel', 'application/x-coel'

      KEYWORDS = Set.new %w[def import let type]

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

        rule(/[()\[\]{}.\\]/, Punctuation)

        rule(/[^()\[\]{}".;\\\s]+/) do |m|
          token name(m[0])
        end
      end
    end
  end
end
