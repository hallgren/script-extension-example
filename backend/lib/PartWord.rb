require "rubygems"
require "neo4j"

# Your domain model
#
class PartWord
  include Neo4j::NodeMixin
  property :pword
  has_n :words
  index :pword
end
