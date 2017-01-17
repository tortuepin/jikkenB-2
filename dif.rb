a = "./out"
b = "ans/df.txt"

def save_hash(lines)
  hash = Hash.new
  lines.each{|line|
    ary = line.split("\t")
    hash[ary[0]] = ary[1]
  }
  return hash
end



f = open(a)
lines = f.readlines
ah = save_hash(lines)
f.close

f = open(b)
lines = f.readlines
bh = save_hash(lines)
f.close


ah.each_key{|key|
  if ah[key] != bh[key] then
    print(ah[key], "\n")
  end
}
