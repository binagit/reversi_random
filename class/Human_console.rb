require 'module/common/Check.rb'
require 'module/human/H_Console.rb'
require 'pp'

#//////////////////////////////////////////////////////////////////////////////////
# Human_consoleクラス
# ------------------------   インスタンス変数   -----------------------------------
#   @conf       設定ファイル 
#   @logger     ロガー
#   @board      ボードの情報（コピーしたものを持つ）
#   @color      人の色
#   @e_color    人の敵の色
# --------------------  インクルードするモジュール -------------------------------
#     Checkモジュール      石が置けるかどうかのメソッド群
#     H_Consoleモジュール  コンソール出力が必要なメソッド群
# ---------------------------- 内容説明 ------------------------------------------
#   人を表すクラス
#   石を置く場所を入力してもらう処理を行なう
#   実際には、H_ConsoleモジュールがCheckモジュールのチェックメソッドを使い、
#   入力される値を求める
#//////////////////////////////////////////////////////////////////////////////////
class Human_console
  #################################################################################
  # 処理内容：
  #  コンストラクタ
  #################################################################################
  def initialize(board, color)
    @conf             = Conf.new
    @logger           = Logger.new(@conf.log_file, @conf.log_rotate)
    @logger.level     = @conf.log_level
    @logger.progname  = __FILE__ 
    @logger.debug{ 'Human_console initialize start' }

    @board = board.dup
    @color = color
    @e_color = @color == 'W' ? 'B' : 'W'

    @logger.debug{ 'Human_console initialize end' }
  end

  include Check
  include H_Console

end
