require 'class/System_console.rb'
require 'class/Human_console.rb'
require 'class/Com_console.rb'
require 'class/Point.rb'
require 'class/Conf.rb'
require 'logger'
require 'pp'


conf             = Conf.new
logger           = Logger.new(conf.log_file, conf.log_rotate)
logger.level     = conf.log_level
logger.progname  = __FILE__ 
logger.debug{ 'main_console start' }

first_board = [
               ['S','S','S','S','S','S','S','S','S','S'],
               ['S','E','E','E','E','E','E','E','E','S'],
               ['S','E','E','E','E','E','E','E','E','S'],
               ['S','E','E','E','E','E','E','E','E','S'],
               ['S','E','E','E','W','B','E','E','E','S'],
               ['S','E','E','E','B','W','E','E','E','S'],
               ['S','E','E','E','E','E','E','E','E','S'],
               ['S','E','E','E','E','E','E','E','E','S'],
               ['S','E','E','E','E','E','E','E','E','S'],
               ['S','S','S','S','S','S','S','S','S','S']
              ]

sys = System_console.new(first_board, 'B', 0)

#---------------------------------------------------------------------------
# 先手、後手を決める
#---------------------------------------------------------------------------
sys.commit_player

# ボードを表示
sys.print_board

while !sys.is_game_over
  logger.debug{ '手数: ' + sys.turn.to_s }
  logger.debug{ 'プレイヤー: ' + "\n" + sys.get_player.pretty_inspect }

  if !sys.is_pass then
    logger.debug{ 'パスでない' }
    #---------------------------------------------------------------------------
    # パスでない場合
    #---------------------------------------------------------------------------
    # 石を打つ座標を取得
    point_info = sys.get_player.select_point_info
    logger.debug{ '置く場所: ' + point_info.pretty_inspect }

    # 打った座標を登録
    sys.point = point_info[:point]
    # ボードを更新
    sys.update(point_info)
    # 手数を更新
    sys.turn = sys.turn + 1
    # ボードを表示
    sys.print_board
  else
    logger.debug{ 'パス' }
    #---------------------------------------------------------------------------
    # パスの場合
    #---------------------------------------------------------------------------
    # パスであることを表示
    sys.print_pass
  end

  # 次の手番のプレイヤーに交代
  sys.change_player
 
  # 次の手番の色に交代
  sys.change_color
end

logger.debug{ 'main_console end' }
