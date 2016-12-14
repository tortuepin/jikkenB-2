def getWord(w)
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
                n += 1
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
    while tmp != "EOS" && !tmp.nill? do
        word = getWord(tmp)
        if !wordArr.include?(word) then
	        wordArr.push(word)
    	    wei.push(idf[word])
        else
    	    wei[wordArr.index(word)] += idf[word]
        end
    end

    for i in 0..wordArr.length-1 do
        print(wordArr[i], ":",  "\t")
    end
    print("\n")
    if tmp.nill? then
        break
    end 
end


