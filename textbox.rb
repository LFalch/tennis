class TextBox
  def initialize(window, text, y, timeout)
    @window = window
    @timer = timeout
    @font = Gosu::Font.new(@window, Gosu.default_font_name, 24)
    @text = text
    @x = (@window.width - @font.text_width(@text)) / 2
    @y = y
  end

  def draw
    if @timer > -1600
      @timer -= 1
    end
    colour = 0xff_ffffff
    if @timer < 0
      colour = 0x01_000000 * (255 * Math::cos(@timer/1600.0*Math::PI/2)).truncate
               + 0x00_ffffff
    end
    @font.draw(@text, @x, @y, 2, 1, 1, colour)
  end
end
