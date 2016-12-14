def getWord(w)
    if w.nil? then
        return nil
    end
    return w.split(" ")[0]
end


while true do
    wordArr = []
    wei = []
    tmp = gets
    word = getWord(tmp)
    while !word.eql?("EOS") && !word.nil? do
        if !wordArr.include?(getWord(word)) then
            wordArr.push(getWord(word))
            wei.push(1)
        end
        tmp = gets
        word = getWord(tmp)
    end

    for i in 0..wordArr.length-1 do
        print(wordArr[i], ":", wei[i], "\t")
    end
    print("\n")
    if tmp.nil? then
        break
    end
end


