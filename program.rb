require_relative 'services/file_parser'
require_relative 'services/address_validator'

file_name = ARGV.last
parsed_file = FileParser.parse_csv_file(file_name)
results = []
if parsed_file[:status_code] == 200
  parsed_file[:data].each do |address|
    results << "#{address.values.join(', ')} -> #{AddressValidator.new(address).validate}"
  end
else
  results << parsed_file[:message]
end
puts results
