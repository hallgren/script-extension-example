
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'DbDriver'

class NewClassTest < Test::Unit::TestCase

  def test_GetHoleWordsFromPartWord

    db_path = './Neo4JDB/searchengine_db'

    driver = DbDriver.new(db_path)

    wArray = []

    wArray << 'hej'
    wArray << 'hejsan'
    wArray << 'help'
    wArray << 'hello'
    wArray << 'hell'
    wArray << 'hell'

    wArray.each { |w|
     driver.CreateHoleWord(w, 1)
    }

    wordArray = driver.FindHoleWordByPartWord('o');
    assert_equal(0, wordArray.count)

    wordArray = driver.FindHoleWordByPartWord('he');
    assert_equal(5, wordArray.count)
    puts wordArray.count
    wordArray = driver.FindHoleWordByPartWord('hej');
    assert_equal(2, wordArray.count)

    wordArray = driver.FindHoleWordByPartWord('hejs');
    assert_equal(1, wordArray.count)

    wordArray.each { |word|
      assert_equal("hejsan", word)
    }

  end

end
