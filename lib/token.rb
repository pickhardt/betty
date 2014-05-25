require 'pry'
class Token
  def initialize(string, options = {})
    options[:text_to_search] = string
    build_readers_for(options)
    definition_list = self.class.definition_list
    unless definition_list.last.respond_to? :call
      concept_config = self.class.concept_config
      @definition_instances = []
      @concept_instances = {}
      rest = string
      definition_list.each do |concept_name|
        concept = concept_config[concept_name]
        concept_instance = concept[:token_class].new(rest, concept)
        rest = concept_instance.match.post_match
        @definition_instances << concept_instance
        @concept_instances[concept_name] = concept_instance
      end
      build_readers_for(@concept_instances)
    end
  end

  def match
    @match ||= begin
      if self.class.definition_list.last.respond_to? :call
        instance_eval(&self.class.definition_list.last)
      else
        @definition_instances.map do |concept_instance|
          concept_instance.match
        end
      end
    end
  end

  private

  def build_readers_for(hash)
    singleton = class << self; self end
    hash.each do |key, value|
      singleton.class_eval{attr_reader key}
      instance_variable_set("@#{key}", value)
    end
  end

  class << self
    module Base
      def concepts(options)
        @concepts = options
      end

      def concept(options)
        name = options.first.first
        options[:token_class] = options.delete(name)
        @concepts ||= {}
        @concepts[name] = options
      end

      def definition(*options)
        @definition = options
      end

      def definition_list
        @definition
      end

      def concept_config
        @concepts
      end

      ##
      # For backwards api compatability
      def interpret(command)
        responses = []
        object = new(command)

        if object.match
          responses << object.call
        end

        responses
      end
    end

    def inherited(subclass)
      subclass.instance_eval do
        extend Base
      end
    end
  end
end
