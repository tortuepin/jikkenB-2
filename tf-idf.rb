def getWord(w)
    if w.nil? then
        return nil
    end
    return w.split(" ")[0]
end

def makeIdf(filenames)
    idf = {}
    n = 0
    filenames.each{|filename|
        f = open(filename)
        tmpIdf = []
        while tmp = f.gets
            word = getWord(tmp)
            if word == "EOS"
                tmpIdf = []
            end
            if idf.has_key?(word)
                if !tmpIdf.include?(word)
                    idf[word] += 1
                    tmpIdf.push(word)
                end
            else
                idf.store(word, 1)
                if !tmpIdf.include?(word)
                    tmpIdf.push(word)
                end
            end
        end
        f.close
    }
    #ここまででdf値がもとまる

    #idfをもとめる

    n = 1000
    idf.each_key do |key|
#        print(idf[key], ":", key, "\n")
        dftmp = n/idf[key] 
        dftmp = Math.log(dftmp) + 1
        idf[key] = dftmp
    end
    return idf
end




filenames = ["./text/train.cleaner.me", "./text/train.mp3player.me", "./text/test.me"]
idf = makeIdf(filenames)
hata = 0
while true do
    wordArr = []
    wei = []
    tmp = gets
    word = getWord(tmp)
    while !word.eql?("EOS") && !word.nil? do
        word = getWord(tmp)
        if !wordArr.include?(word) then
	        wordArr.push(word)
    	    wei.push(idf[word])
        else
    	    wei[wordArr.index(word)] += idf[word]
        end
	tmp = gets
    end

    for i in 0..wordArr.length-1 do
        print(wordArr[i], ":", wei[i].round, "\t")
    end
    print("\n")
    if tmp.nil? then
        break
    end 
end


