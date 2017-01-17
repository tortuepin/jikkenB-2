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
        dftmp = n/idf[key] 
        dftmp = Math.log(dftmp) + 1
        idf[key] = dftmp
    end
    return idf
end

def makeTf(lines)
  tf = {}
  lines.each{|line|
    word = getWord(line)
    if !tf.has_key?(word) then
      tf[word] = 1
    else
      tf[word] += 1
    end
  }
  return tf
end


filenames = ["./text/train.cleaner.me", "./text/train.mp3player.me", "./text/test.me"]
idf = makeIdf(filenames)
lines=[]

STDIN.each{|line|
  if !(getWord(line) == "EOS") then
    lines.push(line)
  else
    tf = makeTf(lines)
    tf_idf = {}
    tf.each_key{|key|
      tf_idf[key] = idf[key]*tf[key]
    }
    ary = tf_idf.sort{|a, b| b[1] <=> a[1]}
    ary.each{|val| print(val[0], ":", val[1], " ")}
    lines=[]
    print("\n")
  end
}

