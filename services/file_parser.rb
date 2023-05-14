require 'csv'

class FileParser
  COLUMN_NAMES = ['Street', 'City', 'Zip Code']

  def self.parse_csv_file(filename, column_names = COLUMN_NAMES)
    return { message: "File not found: '#{filename}'", status_code: 404, data: [] } unless File.exist?(filename)

    file_content = []
    CSV.foreach(filename, headers: true) do |row|
      return { message: "Invalid Headers. Expected: #{column_names.join(', ')}", status_code: 400, data: [] } unless row.headers == column_names
      
      file_content << column_names.map { |column_name| [column_name.downcase.gsub(' ', '_').to_sym, row[column_name]] }.to_h
    end
    { message: "Succesful Response", status_code: 200, data: file_content }
  end
  
end
