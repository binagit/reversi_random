#//////////////////////////////////////////////////////////////////////////////////
# Updateモジュール
# --------------------- インクルードされるクラス -----------------------------------
#   Com_*クラス
#   System_*クラス
# ---------------------------- 内容説明 ------------------------------------------
#   ボードを更新するための関数を集めたモジュール
#//////////////////////////////////////////////////////////////////////////////////
module Update
  #################################################################################
  # 処理内容：
  #  受け取ったPointと方向を元に石をひっくり返す
  #################################################################################
  def update(mobility_info)
    @logger.debug{ 'update start' }
    @logger.debug{ 'mobility_info : ' + "\n" + mobility_info.pretty_inspect }
    @board[mobility_info[:point].y][mobility_info[:point].x] = @color

    mobility_info[:dir].each{|dir|
      @logger.debug{ 'call : ' + "\n" + dir.pretty_inspect } 
      self.method( 'update_' + dir ).call(mobility_info[:point])
    }
    @logger.debug{ 'update end' }
  end

  #################################################################################
  # 処理内容：
  #  上向きにひっくり返す
  #################################################################################
  def update_up(point)
    update_y, update_x = point.y-1, point.x
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_y                    = update_y - 1
    end
  end

  #################################################################################
  # 処理内容：
  #  下向きにひっくり返す
  #################################################################################
  def update_down(point)
    update_y, update_x = point.y+1, point.x
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_y                    = update_y + 1
    end
  end

  #################################################################################
  # 処理内容：
  #  左向きにひっくり返す
  #################################################################################
  def update_left(point)
    update_y, update_x = point.y, point.x-1
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_x                    = update_x - 1
    end
  end

  #################################################################################
  # 処理内容：
  #  右向きにひっくり返す
  #################################################################################
  def update_right(point)
    update_y, update_x = point.y, point.x+1
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_x                    = update_x + 1
    end
  end

  #################################################################################
  # 処理内容：
  #  右上向きにひっくり返す
  #################################################################################
  def update_right_up(point)
    update_y, update_x = point.y-1, point.x+1
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_y                    = update_y - 1
      update_x                    = update_x + 1
    end
  end

  #################################################################################
  # 処理内容：
  #  左上向きにひっくり返す
  #################################################################################
  def update_left_up(point)
    update_y, update_x = point.y-1, point.x-1
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_y                    = update_y - 1
      update_x                    = update_x - 1
    end
  end

  #################################################################################
  # 処理内容：
  #  左下向きにひっくり返す
  #################################################################################
  def update_left_down(point)
    update_y, update_x = point.y+1, point.x-1
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_y                    = update_y + 1
      update_x                    = update_x - 1
    end
  end

  #################################################################################
  # 処理内容：
  #  右下向きにひっくり返す
  #################################################################################
  def update_right_down(point)
    update_y, update_x = point.y+1, point.x+1
    while @board[update_y][update_x] != @color
      @board[update_y][update_x]  = @color
      update_y                    = update_y + 1
      update_x                    = update_x + 1
    end
  end
end
