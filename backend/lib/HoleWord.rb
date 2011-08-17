require "rubygems"
require "neo4j"

# Your domain model
#
class HoleWord
  include Neo4j::NodeMixin
  property :word
  has_n :nodes
  index :word
end
