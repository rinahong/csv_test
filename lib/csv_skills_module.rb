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
