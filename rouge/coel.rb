module Rouge
  module Lexers
    # Coel programming language lexer
    class Coel < RegexLexer
      title 'Coel'
      desc 'Coel programming language'

      tag 'coel'

      filenames '*.coel'

      mimetypes 'text/x-coel', 'application/x-coel'

      def self.keywords
        @keywords ||= Set.new %w[def import let]
      end

      def self.builtins
        @builtins ||= Set.new %w[
          + - * / ** // = < <= > >=
          and catch delete dict dump error eseq first
          if include indexOf insert ordered?
          list map matchError max merge min mod not
          or par partial prepend pure rally read reduce rest
          seq size slice toList toStr typeOf write zip
        ]
      end

      def name_token(name)
        return Keyword if self.class.keywords.include?(name)
        return Name::Builtin if self.class.builtins.include?(name)
        nil
      end

      state :root do
        rule(/;.*?$/, Comment::Single)
        rule(/\s+/m, Text::Whitespace)

        rule(/-?\d+(\.\d+)?/, Num::Float)
        rule(/0x[0-9a-fA-F]+/, Num::Hex)
        rule(/"(\\.|[^"])*"/, Str)

        rule(/[()\[\]{}.\\]/, Punctuation)

        rule(/[^()\[\]{}".;\\\s]+/) do |m|
          token name_token(m[0]) || Name
        end
      end
    end
  end
end
