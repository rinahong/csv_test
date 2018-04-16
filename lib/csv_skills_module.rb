# NOTE Do this last.
#
# Imagine our interface was something like this:
#   counter = DomainCounter.read_file("path/to/file")
#   counter["good_domain.com"] # => 100
#   counter["non_existent.com"] # => 0
#   counter.to_hash # => {"domain" => 1, ...}
#   counter.write_file("path_to_file")
#
# Can you update the existing code to offer this interface?

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'csv'

module DomainCounter
  def self.read_file(read_file)
    domain_counts = Hash.new(0)
    CSV.foreach(read_file) do |row|
      domain = get_domain(row[1])
      domain_counts[domain] += 1
    end
    domain_counts
  end

  def self.get_domain(email_address)
    email_address.partition('@').last
  end

  def write_file(write_file)
    CSV.open(write_file, "wb") do |csv|
      csv << ["domain", "count"]
      self.each do |key, value|
        csv << [key, value.to_s]
      end
    end
  end
end
