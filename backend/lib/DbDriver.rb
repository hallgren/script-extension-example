require "rubygems"
require "neo4j"
require "PartWord"
require "HoleWord"
require "Node"
require "WordParser"

class DbDriver

  def initialize()
  #  Neo4j::Config[:storage_path] = db_path 
  end

  def CreateHoleWord(word, nodeId)

    wordParser = WordParser.new
    pwordarray = wordParser.ParseWord(word)

    Neo4j::Transaction.run do

      node = (Node.new :nodeId=>nodeId)

      search = HoleWord.find(:word => word)

      if search.empty?
        holeword = HoleWord.new :word=>word
      else
       holeword = search.first
      end

      LinkNodeToHoleWord(holeword,node)
      CreatePartWords(pwordarray, holeword)
      holeword
    end

  end


  def FindHoleWordByPartWord(partword)

    words = []
      pw = PartWord.find(:pword => partword)
      if !pw.empty? 
        pw.first.words.each { |word|
          words << word.word
        }
      end
    words
  end


private

  def CreatePartWords(pwords, hw)

   # Neo4j::Transaction.run do
      partwords = []

      pwords.each { |pw|
        search = PartWord.find(:pword => pw)
        if (search.empty?) 
         partword = PartWord.new(:pword => pw)
        else
          partword = search.first
        end

        LinkHoleWordToPartWord(partword, hw)
        partwords << partword
      }

      partwords
   # end
  end

  def LinkNodeToHoleWord(word, node)
    if !word.nodes.include?(node)
      word.nodes << node
      return true
    else
      return false
    end

  end

  def LinkHoleWordToPartWord(partword, word)

    if !partword.words.include?(word)
      partword.words << word
      return true
    else
      return false
    end

  end

end
