# This controls the player
class Player2
  attr_reader :x, :y, :radius

  def initialize(window)
    @window = window
    @image = Gosu::Image.new('media/halvmåne.png')
    @radius = @image.height     # Read size of player from the image.
    @margin = 5                 # Don't go too close to the edge.
    @x = @window.width-100
    @y = @window.height - @image.height + @radius - @margin     # This is just a constant.

    # (@x, @y) are the coordinates of the center of the player.
  end

  def move_right
    @x = [@x + 4, @window.width - @margin - @radius].min
  end

  def move_left
    @x = [@x - 4,
          @window.width / 2 + @window.wall.width / 2 + @radius + @margin].max
  end

  # This controls the movement of the player2
  def update
    if (@window.button_down? Gosu::KbLeft) ||
       (@window.button_down? Gosu::GpLeft)
      move_left
    end

    if (@window.button_down? Gosu::KbRight) ||
       (@window.button_down? Gosu::GpRight)
      move_right
    end
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 0, 1, 1, 0xff_00ff00)
  end
end
