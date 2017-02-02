def getWord(w)
  if w.nil? then
      return nil
  end
  return w.split(" ")[0]
end

def makeP(filename)
  f = open(filename)
  tmpP = Hash.new
  sum = 0
  while tmp = f.gets
    word = getWord(tmp)
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
