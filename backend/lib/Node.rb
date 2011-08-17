require "rubygems"
require "neo4j"

# Your domain model
#
class Node
  include Neo4j::NodeMixin
  property :nodeId
  index :nodeId
end

