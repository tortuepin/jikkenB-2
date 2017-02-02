ruby nb-training.rb text/train.cleaner.me > nbans/cleaner_nb
ruby nb-training.rb text/train.mp3player.me > nbans/mp3player_nb
ruby nb-test.rb -a nbans/cleaner_nb -b nbans/mp3player_nb < text/test.me > nbans/nb
ruby eval.rb -a nbans/nb -r ans/ans.txt
