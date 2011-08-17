require "sinatra"
require "neo4j"
require "DbDriver"
require "HoleWord"

class Backend < Sinatra::Base

  configure do
    unless $NEO4J_SERVER
      Neo4j::Config[:storage_path] = '~/Downloads/neo4j-community-1.4/data/graph.db'
    end
    driver = DbDriver.new()
    unless HoleWord.find(:word => "hejsan").first

      puts "###"
        driver = DbDriver.new()

        wArray = []

        wArray << 'help'
        wArray << 'hej'
        wArray << 'hejsan'
        wArray << 'hello'
        wArray << 'hell'
        wArray << 'hell'

        wArray.each { |w|
          driver.CreateHoleWord(w, 1)
        }

    end
  end

  get "/words/:name" do |name|
    driver = DbDriver.new()
    words = driver.FindHoleWordByPartWord(name)
    return unless words
    puts words.count
    words.each do |w| 
      puts w
    end
    return words.to_json
  end

end
