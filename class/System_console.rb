require 'module/common/Check.rb'
require 'module/common/Update.rb'
require 'module/system/S_Console.rb'
require 'class/Human_console.rb'
require 'class/Com_console.rb'
require 'class/Conf.rb'
require 'logger'
require 'pp'

#//////////////////////////////////////////////////////////////////////////////////
# System_consoleクラス
# ------------------------   インスタンス変数   -----------------------------------
#     @board    思考対象時のボード
#     @color    思考対象時の色
#     @e_color  思考対象時の的の色
#     @turn     思考対象時の手数
#     @point    今回プレイヤーが打った座標
#     @player   [
#                思考対象時の手数のときのプレイヤーが0要素目,
#                思考対象時の手数のときにプレイヤーでないものが1要素目
#               ]
# --------------------  インクルードするモジュール -------------------------------
#     S_Consoleモジュール  コンソール出力が必要なメソッド群
#     Checkモジュール      石が置けるかどうかのメソッド群
#     Updateモジュール     ボードを更新するメソッド群
# ---------------------------- 内容説明 ------------------------------------------
#  システムを表すクラス
#    ボードの更新
#    ボードの表示
#    人の先手、後手を決める
#    ゲームの終了判定
#      を行なう
#//////////////////////////////////////////////////////////////////////////////////
class System_console
  #################################################################################
  # 処理内容：
  #  コンストラクタ
  #
  # 引数:
  #  board  思考対象のボード  
  #  color  思考対象時の打ち手の色
  #  turn   思考対象時の手数
  #################################################################################
  def initialize(board, color, turn)
    @conf             = Conf.new
    @logger           = Logger.new(@conf.log_file, @conf.log_rotate)
    @logger.level     = @conf.log_level
    @logger.progname  = __FILE__ 
    @logger.debug{ 'System_console initialize start' }

    @board   = board
    @color   = color
    @e_color = @color == 'W' ? 'B' : 'W' 
    @turn    = turn
    @point   = Point.new(0,0)
    @player  = []

    @logger.debug{ 'System_console initialize end' }
  end

  attr_accessor :board, :color, :e_color, :turn, :point

  include Check
  include Update
  include S_Console

  #################################################################################
  # 処理内容：
  #  今回パスかどうか判断する
  # 戻り値：
  #   false  パスでない場合
  #   true   パスである場合
  #################################################################################
  def is_pass
    @logger.debug{ 'is_pass start' }

    if self.get_mobility_info.length == 0 then
      @logger.debug{ 'is_pass end : return true' }
      return true
    else
      @logger.debug{ 'is_pass end : return false' }
      return false
    end
  end

  #################################################################################
  # 処理内容：
  #  ゲーム終了判定
  # 戻り値：
  #   false  終了でない場合
  #   true   終了である場合
  #################################################################################
  def is_game_over
    @logger.debug{ 'is_game_over start' }
    #----------------------------------------------------------------------------#
    # 現在の手で置ける場所があるか調べる
    #----------------------------------------------------------------------------#
    if self.is_pass then
      #----------------------------------------------------------------------------#
      # 次の手番でも置ける場所があるか調べる
      #----------------------------------------------------------------------------#
      # 次の手に色を変える
      self.change_color

      if self.is_pass then
        # 次の手番でも置ける場所がなかったのでゲームオーバー
        @logger.debug{ 'is_game_over end : return true' }
        return true
      end

      # 元の手に色を戻す
      self.change_color
    end

    @logger.debug{ 'is_game_over end : return false' }
    return false
  end

  #################################################################################
  # 処理内容：
  #  現在手番のプレイヤーを登録
  #################################################################################
  def commit_player
    @logger.debug{ 'commit_player start' }
    if self.select_human_turn == 'B' then
      @player[0] = Human_console.new(@board, 'B')
      @player[1] = Com_console.new(@board, 'W')
    else
      @player[0] = Com_console.new(@board, 'B')
      @player[1] = Human_console.new(@board, 'W')
    end
    @logger.debug{ 'commit_player end' }
  end

  #################################################################################
  # 処理内容：
  #  次の手番用にプレイヤーを交代
  #################################################################################
  def change_player
    @logger.debug{ 'change_player start' }
    @player.reverse!
    @logger.debug{ 'change_player end' }
  end

  #################################################################################
  # 処理内容：
  #  次の手番用に色を交代
  #################################################################################
  def change_color
    @logger.debug{ 'change_color start' }
    @color, @e_color = @e_color, @color
    @logger.debug{ 'change_color end' }
  end

  #################################################################################
  # 処理内容：
  #  現在の手番のプレイヤーを返す
  #################################################################################
  def get_player
    @player[0]
  end

end
