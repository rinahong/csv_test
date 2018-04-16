require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'csv'

def parse_file
  data = File.read("spec/fixtures/roster.csv")
  rows = data.split("\n")
  domain_counts = {}
  rows.each do |row|
    element = row.split(",")
    domain = element[1].partition('@').last
    unless domain_counts.has_key?(domain)
      domain_counts[domain] = 0
    end
    domain_counts[domain] += 1
  end

  write_file(domain_counts)
end

# def parse_file
#   data = File.read("spec/fixtures/roster.csv")
#   domain_regex = /@([a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z])/
#   domains_array = data.scan(domain_regex)
#   domain_counts = {}
#   domains_array.each do |domain|
#     domain_string = domain.join()
#     unless domain_counts.has_key?(domain_string)
#       domain_counts[domain_string] = 0
#     end
#     domain_counts[domain_string] += 1
#   end
#   write_file(domain_counts)
# end


def write_file(domain_counts)
  CSV.open("output.csv", "wb") do |csv|
    csv << ["domain", "count"]
    domain_counts.each do |key, value|
      csv << [key, value.to_s]
    end
  end
end

parse_file
