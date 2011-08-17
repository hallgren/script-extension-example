class WordParser

  def ParseWord(word)

    result = [];

    word.length.times { |i|
      result << word[0..i]
    }

    return result

  end

end
