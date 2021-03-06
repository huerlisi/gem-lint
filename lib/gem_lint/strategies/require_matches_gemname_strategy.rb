require 'find'

module GemLint
  module Strategies
    class RequireMatchesGemnameStrategy < AbstractStrategy

      def description
        "Gem cannot be loaded by require '#{preferred_basename.gsub(/^lib\//,'')}'"
      end

      def tag
        :"require-doesnt-match-gemname"
      end

      def level
        :warning
      end

      # TODO: does thi need to be beefed up to recognise extensions
      #
      def fail?
        !spec.files.include?(preferred_filename)
      end

      private

      def preferred_basename
        "lib/" + spec.name.tr("-","/")
      end

      def preferred_filename
        preferred_basename + ".rb"
      end

      def spec
        @spec ||= YAML.load(File.read(@metadata_path))
      end

    end
  end
end

