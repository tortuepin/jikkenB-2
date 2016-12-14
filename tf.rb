def getWord(w)
    return w.split(" ")[0]
end

wordArr = []
wei = []

while tmp = gets do
    word = getWord(tmp)
    if !wordArr.include?(word) then
        wordArr.push(word)
        wei.push(1)
    else
        wei[wordArr.index(word)] += 1
    end
end


for i in 0..wordArr.length-1 do
    print(wordArr[i], ":", wei[i], "\t")
end
