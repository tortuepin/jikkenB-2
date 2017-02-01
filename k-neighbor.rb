#!/usr/bin/env/ ruby

class Vec
  def initialize(className, vec)
    @name = className;
    @vec = vec;
  end
  
  def get_class()
    return @name;
  end

  def get_vec()
    return @vec
  end
end

def read_vec(vecline, name)
  ary = vecline.scan(/([^:\s]+):(\d+\.\d+)/);
  hash = Hash[ary];
  vec = Vec.new(name, hash);
  return vec;
end
def read_input_vec(line)
  ary = line.scan(/([^:\s]+):(\d+\.\d+)/);
  hash = Hash[ary];
  hash = Hash[ary];
  Vec.new("none", hash);
end

def sim(vec1, vec2)
  def size(vec)
    size = 0;
    vec.each_value{|val|
      size += val.to_f*val.to_f;
    }
    return Math.sqrt(size)
  end

  def product(vec1, vec2)
    ret = 0;
    vec1.each_key{|key|
      if vec2.has_key?(key) then
        ret += vec1[key].to_f*vec2[key].to_f;
      end
    }
    return ret;
  end
  v1 = vec1.get_vec();
  v2 = vec2.get_vec();
  if size(v1) == 0 || size(v2) == 0 then
  end

  return product(v1, v2)/(size(v1)*size(v2)).to_f
end


#--コマンドライン引数読み込み--#
#仮
#
num = 0;
argA = -1;
argB = -1;
argK = -1;
ARGV.each{ |arg|
  case arg
  when "-a" then
    argA = num+1;
  when "-b" then
    argB = num+1;
  when "-k" then
    argK = num+1;
  end
  num += 1;
}
if argA != -1 then
  cleanerVecFile = ARGV[argA]
end
if argB != -1 then
  mp3playerVecFile = ARGV[argB]
end
if argK != -1 then
  $k = ARGV[argK].to_i
end


#$k = 5;
#cleanerVecFile = "text/train.cleaner.vec=tfidf.txt"
#mp3playerVecFile = "text/train.mp3player.vec=tfidf.txt"

#--教師文書を読み込む--#
tid = 0;
space = Hash.new;
open(cleanerVecFile).each{ |line|
  space[tid] = read_vec( line, 'cleaner'); tid += 1;
}
open(mp3playerVecFile).each{ |line|
  space[tid] = read_vec( line, 'mp3player'); tid += 1;
}


#--入力文書に対する処理--#
STDIN.each{ |x|
  input = read_input_vec(x);

  # 類似度計算
  s = Hash.new;
  space.keys.each{ |id| v = space[id];
    s[id] = sim(input, v);
  }

  # 近傍文書の獲得
  class_a_count = 0; count = 0;
  s.keys.sort{ |x,y| s[y] <=> s[x] }.each{ |id|
    break if count >= $k;
    class_a_count += 1 if space[id].get_class() == 'cleaner';
    count += 1;
  }

  # 意思決定
  output_class = class_a_count * 2 > $k ? 'cleaner' : 'mp3player';
  puts output_class;
}

