class CsvUpload < ApplicationRecord
    HEADERS = ["Company", "Practice", "Asset Class", "Job Function", "Rudy Locations"].freeze
  
    belongs_to :user
  
    attribute :file
  
    validates :companies_applied, json: true
    validates :companies_discarded, json: true
    validates :companies_failed, json: true
    validates :csv_content, csv: true, presence: true
    validates :csv_filename, presence: true
    validates :file, presence: true, file_type: { mime: :csv, type: :text }, on: :create
  
    %w[applied discarded failed].each do |kind|
      define_method("companies_#{kind}_hashes".to_sym) do
        return {} if new_record?
  
        JSON.parse(public_send("companies_#{kind}")).deep_symbolize_keys
      rescue TypeError, JSON::ParserError
        {}
      end
  
      define_method("companies_#{kind}_count".to_sym) do
        new_record? ? 0 : public_send("companies_#{kind}_hashes").count
      end
    end
  
    def file=(attachment)
      return unless attachment
  
      raise TypeError unless [ActionDispatch::Http::UploadedFile, Rack::Test::UploadedFile].include? attachment.class
  
      file = attachment.read
  
      self.csv_content = file
      self.csv_filename = attachment.original_filename
  
      super
    end
  end
  