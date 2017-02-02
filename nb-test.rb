#!/usr/bin/env/ ruby
include Math

def getWord(w)
  if w.nil? then
      return nil
  end
  return w.split(" ")[0]
end

def makeN(lines)
  hash = Hash.new
  lines.each{|word|
    if hash.include?(word) then
      hash[word] += 1
    else
      hash[word] = 1
    end
  }
  return hash
end

def getP(word, p)
  if p.has_key?(word) then
    return p[word]
  else
    return p["non_exist"]
  end
end

# コマンド読み込み
num = 0;
argA = -1;
argB = -1;
ARGV.each{ |arg|
  case arg
  when "-a" then
    argA = num+1;
  when "-b" then
    argB = num+1;
  end
  num += 1;
}
if argA != -1 then
  cleanerVecFile = ARGV[argA]
end
if argB != -1 then
  mp3playerVecFile = ARGV[argB]
end

#--教師文書を読み込む--#
cleaner_p = Hash.new
mp3player_p = Hash.new
open(cleanerVecFile).each{ |line|
  tmp = line.split(":")
  cleaner_p[tmp[0]] = tmp[1].to_f
}
open(mp3playerVecFile).each{ |line|
  tmp = line.split(":")
  mp3player_p[tmp[0]] = tmp[1].to_f
}


lines = []
STDIN.each{ |line|
  if !(getWord(line) == "EOS") then
    lines.push(getWord(line))
  else
    #print(lines)
    cleaner_sum = 0
    mp3player_sum = 0
    # nを計算する
    n = makeN(lines)

    
    # linesに含まれる全ての単語についてのn*log(p)の合計を計算
    lines.each{|word|
      cleaner_sum += n[word]*Math.log(getP(word, cleaner_p).to_f).to_f
      mp3player_sum += n[word]*Math.log(getP(word, mp3player_p).to_f).to_f
#      print(n[word], " ", word, "\n")
    }

    # 意思決定
    output_class = cleaner_sum >= mp3player_sum ? 'cleaner' : 'mp3player';
    puts output_class;
    lines = []
  end
}
