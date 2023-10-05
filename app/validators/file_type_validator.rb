# frozen_string_literal: true

class FileTypeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank? # presence validation should handle this
  
      validate_mime_option!
  
      if expected_content_types.any?
        unless expected_content_types.include? value.content_type
          record.errors.add attribute, :wrong_mime_type, expected: expected_content_types.join(", "), provided: value.content_type
        end
      end
  
      case options[:type]
      when :text
        record.errors.add attribute, "is expected to be a text file but is binary" unless text_file?(value.path)
      when :binary
        record.errors.add attribute, "is expected to be a binary file but is a text file" if text_file?(value.path)
      else
        raise ArgumentError, ":type key must be either :text or :binary" if options[:type]
      end
    end
  
    private
  
    def text_file?(file_path)
      file_type, status = Open3.capture2e("file", file_path)
      status.success? && file_type.split(":").last.include?("text")
    end
  
    # @return [Array<Symbol, String>] example: ["csv", :exe]
    def mime_keys
      Array(options[:mime])
    end
  
    # @raise ArgumentError
    def validate_mime_option!
      unrecognized_mime_keys = (mime_keys.map(&:to_s) - Mime::EXTENSION_LOOKUP.keys)
  
      if unrecognized_mime_keys.any?
        raise ArgumentError, [
          unrecognized_mime_keys.map { "“#{_1}”" }.to_sentence,
          (unrecognized_mime_keys.many? ? "are" : "is"),
          "unrecognized as Mime type",
        ].join(" ")
      end
    end
  
    # @return [Array<Mime::Type>]
    def mime_types
      mime_keys.map { Mime[_1] }
    end
  
    # @return [Array<String>] example: ["text/csv", "image/png"]
    def expected_content_types
      mime_types.map(&:to_s)
    end
  end
  