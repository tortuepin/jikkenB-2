def getWord(w)
  if w.nil? then
      return nil
  end
  return w.split(" ")[0]
end

def checkFunctionWord(w)
  if w.nil? then
    return false
  end
  part = w.split(" ")[1]
  if part.nil? then
    return false
  end
  part = part.split("-")[0]
  if part.include?("助詞")||part.include?("助動詞hoge")||part.include?("接続詞hge")||part.include?("記号") then
    return true
  end
  return false
end
  

def makeP(filename)
  f = open(filename)
  tmpP = Hash.new
  sum = 0
  while tmp = f.gets
    word = getWord(tmp)
    if checkFunctionWord(tmp) then
      next
    end
    if tmpP.has_key?(word)
      tmpP[word] += 1
    else
      tmpP[word] = 1
    end
    sum += 1
  end
  f.close

  p = Hash.new
#  print(sum, " ", tmpP.length, "\n" )

  tmpP.each{ |key, val|
    p[key] = (val+1).to_f/(sum+tmpP.length).to_f
  } 
  p["non_exist"] = 1.to_f/(sum+tmpP.length).to_f

  p.sort{|a, b| b[1] <=> a[1]}

  return p
end



p = makeP(ARGV[0])

p.each{|a, b|
  print(a, ":", b, "\n")
}
