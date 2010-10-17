#//////////////////////////////////////////////////////////////////////////////////
# Checkモジュール
# --------------------- インクルードするクラス -----------------------------------
#   Com_*クラス
#   Human_*クラス
# ---------------------------- 内容説明 ------------------------------------------
#   石が置けるかどうかチェックする関数群を集めたモジュールである
#   石が置ける座標を列挙する関数も持つ
#//////////////////////////////////////////////////////////////////////////////////

module Check
  #################################################################################
  # 処理内容：
  #  座標が'E'でなあるかチェック
  #  （つまりすでに石が置かれていないかチェック）
  # 戻り値：
  #   true   座標が'E'であるとき
  #   false  座標が'E'でないとき
  #################################################################################
  def is_empty(point)
    @board[point.y][point.x] == 'E' ? true : false
  end

  #################################################################################
  # 処理内容：
  #  上向きにひっくり返せるか探索
  # 戻り値：
  #  'up'  上にひっくり返せるとき
  #  ''    上にひっくり返せないとき
  #################################################################################
  def check_up(point)
    if @board[point.y-1][point.x] == @e_color then
      check_y, check_x = point.y-2, point.x
      while @board[check_y][check_x] == @e_color do check_y = check_y - 1 end
      return 'up' if @board[check_y][check_x] == @color
    end

    return ''
  end

  #################################################################################
  # 処理内容：
  #  下向きにひっくり返せるか探索
  # 戻り値：
  #  'down'  下にひっくり返せるとき
  #  ''      下にひっくり返せないとき
  #################################################################################
  def check_down(point)
    if @board[point.y+1][point.x] == @e_color then
      check_y, check_x = point.y+2, point.x
      while @board[check_y][check_x] == @e_color do check_y = check_y + 1 end
      return 'down' if @board[check_y][check_x] == @color
    end

    return ''
  end

  #################################################################################
  # 処理内容：
  #  左向きにひっくり返せるか探索
  # 戻り値：
  #  'left'  左にひっくり返せるとき
  #  ''      左にひっくり返せないとき
  #################################################################################
  def check_left(point)
    if @board[point.y][point.x-1] == @e_color then
      check_y, check_x = point.y, point.x-2
      while @board[check_y][check_x] == @e_color do check_x = check_x - 1 end
      return 'left' if @board[check_y][check_x] == @color
    end

    return ''
  end

  #################################################################################
  # 処理内容：
  #  右向きにひっくり返せるか探索
  # 戻り値：
  #  'right'  右にひっくり返せるとき
  #  ''       右にひっくり返せないとき
  #################################################################################
  def check_right(point)
    if @board[point.y][point.x+1] == @e_color then
      check_y, check_x = point.y, point.x+2
      while @board[check_y][check_x] == @e_color do check_x = check_x + 1 end
      return 'right' if @board[check_y][check_x] == @color
    end

    return ''
  end
    
  #################################################################################
  # 処理内容：
  #  右上向きにひっくり返せるか探索
  # 戻り値：
  #  'right_up'  右上にひっくり返せるとき
  #  ''          右にひっくり返せないとき
  #################################################################################
  def check_right_up(point)
    if @board[point.y-1][point.x+1] == @e_color then
      check_y, check_x = point.y-2, point.x+2
      while @board[check_y][check_x] == @e_color do check_x = check_x + 1; check_y = check_y - 1; end
      return 'right_up' if @board[check_y][check_x] == @color
    end

    return ''
  end
    
  #################################################################################
  # 処理内容：
  #  左上向きにひっくり返せるか探索
  # 戻り値：
  #  'left_up'  左上にひっくり返せるとき
  #  ''         左上にひっくり返せないとき
  #################################################################################
  def check_left_up(point)
    if @board[point.y-1][point.x-1] == @e_color then
      check_y, check_x = point.y-2, point.x-2
      while @board[check_y][check_x] == @e_color do check_x = check_x - 1; check_y = check_y - 1; end
      return 'left_up' if @board[check_y][check_x] == @color
    end

    return ''
  end

  #################################################################################
  # 処理内容：
  #  左下向きにひっくり返せるか探索
  # 戻り値：
  #  'left_down'  左下にひっくり返せるとき
  #  ''           左上にひっくり返せないとき
  #################################################################################
  def check_left_down(point)
    if @board[point.y+1][point.x-1] == @e_color then
      check_y, check_x = point.y+2, point.x-2
      while @board[check_y][check_x] == @e_color do check_x = check_x - 1; check_y = check_y + 1; end
      return 'left_down' if @board[check_y][check_x] == @color
    end

    return ''
  end

  #################################################################################
  # 処理内容：
  #  右下向きにひっくり返せるか探索
  # 戻り値：
  #  'right_down'  右下にひっくり返せるとき
  #  ''            右上にひっくり返せないとき
  #################################################################################
  def check_right_down(point)
    if @board[point.y+1][point.x+1] == @e_color then
      check_y, check_x = point.y+2, point.x+2
      while @board[check_y][check_x] == @e_color do check_x = check_x + 1; check_y = check_y + 1; end
      return 'right_down' if @board[check_y][check_x] == @color
    end

    return ''
  end

  #################################################################################
  # 処理内容：
  #  石を置ける座標を列挙する
  # 返り値：
  #  置ける座標のPointと置ける向きの情報を持った配列
  #  [
  #   { :point => Point.new(座標), :dir => [置ける向き1, 置ける向き2, .. ] },
  #   ...
  #  ]
  #################################################################################
  def get_mobility_info
    @logger.debug{ 'get_mobility_info start' }

    mobility_info = []
    for check_y in (1..@board.length-2).to_a 
      for check_x in (1..@board.length-2).to_a 
        point = Point.new(check_y, check_x)
        #=======================================================================#
        # 'E'である場所を探す
        #=======================================================================#
        if self.is_empty(point) then
          checks = [
                    self.check_up(point), self.check_down(point), self.check_left(point), self.check_right(point),
                    self.check_right_up(point),  self.check_left_up(point),
                    self.check_left_down(point), self.check_right_down(point)
                   ]
          #=======================================================================#
          # 全部 '' でないものがあった場合、 その座標を登録
          #=======================================================================#
          if ! checks.all?{|v| v == ''} then
            mobility_info.push( {:point => point, :dir => checks.select{|v| v != ''}} )
          end
        end
      end 
    end

    @logger.debug{ 'get_mobility_info end : return ' + "\n" + mobility_info.pretty_inspect }
    return mobility_info
  end
end
