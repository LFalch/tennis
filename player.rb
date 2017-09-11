# This controls the player

class Player
  attr_reader :x, :y, :radius

  def initialize(window)
    @window = window
    @image = Gosu::Image.new('media/halvmåne.png')
    @radius = @image.height # Read size of player from the image.
    @margin = 5             # Don't go too close to the edge.
    @secondPlayer = false
    @x = 100
    @y = @window.height - @image.height + @radius - @margin     # This is just a constant.
    @lefts  = [Gosu::KbA, Gosu::KbLeft , Gosu::GpLeft ]
    @rights = [Gosu::KbD, Gosu::KbRight, Gosu::GpRight]

    # (@x, @y) are the coordinates of the center of the player.
  end

  def move_left
    @x = [@x - 4, @margin + @radius].max
  end

  def move_right
    @x = [@x + 4,
          @window.width / 2 - @window.wall.width / 2 - @radius - @margin].min
  end

  def second_player_mode
    @lefts .slice!(1, 2)
    @rights.slice!(1, 2)
  end

  # This controls the movement of the player
  def update
    if @lefts .any? {|k| @window.button_down? k}
      move_left
    end

    if @rights.any? {|k| @window.button_down? k}
       (@window.button_down? Gosu::GpRight)
      move_right
    end
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 0)
  end
end
