#!/usr/bin/env/ ruby

class Vec
  def initialize(className, vec)
    @name = className;
    @vec = vec;
  end
  
  def get_class()
    return @name;
  end
end

def read_vec(vecline, name)
  Vec.new(name);
end
def read_input_vec()
  Vec.new();
end
def sim()

end


#--コマンドライン引数読み込み--#
#仮
#
$k = 5;
cleanerVecFile = "cleanerVec"
mp3playerVecFile = "mp3playerVec"

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
ARGF.each{ |x|
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


