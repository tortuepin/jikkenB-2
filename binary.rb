def getWord(w)
    return w.split(" ")[0]
end

wordArr = []
wei = []

while word = gets do
    if !wordArr.include?(getWord(word)) then
        wordArr.push(getWord(word))
        wei.push(1)
    end
end


for i in 0..wordArr.length-1 do
    print(wordArr[i], ":", wei[i], "\n")
end
