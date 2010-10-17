require 'module/common/Check.rb'
require 'module/common/Update.rb'
require 'module/com/AI_random'
require 'logger'
require 'pp'

#//////////////////////////////////////////////////////////////////////////////////
# Com_consoleクラス
# ------------------------   インスタンス変数   -----------------------------------
#   @conf       設定ファイル 
#   @logger     ロガー
#   @board      ボードの情報（コピーしたものを持つ）
#   @color      コンピュータの色
#   @e_color    コンピュータの敵の色
# --------------------  インクルードするモジュール -------------------------------
#    Checkモジュール      石が置けるかどうかのメソッド群
#    Updateモジュール   　盤を更新する（石をひっくり返す）メソッド群
#    AI_randomモジュール  ランダム打ちAIを搭載するためのメソッド群
# ---------------------------- 内容説明 ------------------------------------------
#    1手読み（ランダム打ち）を行なうコンピュータを表すクラス
#    実際に石が置けるかどうかチェックするのはCheckモジュール   
#    実際にボードの更新を行なうのはUpdateモジュール
#//////////////////////////////////////////////////////////////////////////////////

class Com_console
  #################################################################################
  # 処理内容：
  #  コンストラクタ
  #################################################################################
  def initialize(board, color)
    @conf             = Conf.new
    @logger           = Logger.new(@conf.log_file, @conf.log_rotate)
    @logger.level     = @conf.log_level
    @logger.progname  = __FILE__ 
    @logger.debug{ 'Com_console initialize start' }

    @board   = board.dup
    @color   = color
    @e_color = @color == 'W' ? 'B' : 'W' 

    @logger.debug{ 'Com_console initialize end' }
  end

  #################################################################################
  # インクルード
  #################################################################################
  include Check
  include Update
  include AI_random

end
