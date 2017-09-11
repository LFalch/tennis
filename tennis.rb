# This adds the "gosu" library to the game, which enables various extra
# features!
require 'gosu'

# These are nessecary for THIS code/file to cooperate with the other
# files/codes
require_relative 'player'
require_relative 'player2'
require_relative 'ball'
require_relative 'wall'
require_relative 'bot'
require_relative 'score'
require_relative 'textbox'

# This adds the actual window to the game, which in this case works as a
# controller!
class GameWindow < Gosu::Window
  attr_reader :player, :player2, :wall, :ball, :bot, :score, :twoplayer
  attr_accessor :game_over

  # This is the event that occurs when you start the game, like when the object
  # is "created"
  def initialize
    super(640, 400, false)
    self.caption = 'Tennis Game'

    @player    = Player.new(self)
    @player2   = Player2.new(self)
    @help      = TextBox.new(self, "Press O to activate 2P", 193, 500)
    @bot       = Bot.new(self)
    @ball      = Ball.new(self)
    @wall      = Wall.new(self)
    @score     = Score.new(self)
    @twoplayer = false
    @game_over = false

    @music     = Gosu::Song.new('media/rick.ogg')
    # @music.play(true)
  end

  # This event is checked 60 times per second.
  def update
    self.caption = "Tennis - [FPS: #{Gosu::fps.to_s}]"
    if not @game_over
      # Move the game objects around.
      @player.update
      if @twoplayer
        @player2.update
      else
        @bot.update
      end
      @ball.update
      # No need to call update on wall, since it doesn't move :-)
    end
  end

  # This controls the graphics in the game. Also checks around 60 times per
  # second...
  def draw
    @player.draw
    if @twoplayer
      @player2.draw
    else
      @bot.draw
    end
    @ball.draw
    @wall.draw
    @score.draw
    @help.draw
  end

  # This checks when you press ESC
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
    if id == Gosu::KbO && (not @twoplayer)
      @twoplayer = true
      @player.second_player_mode
    end
    if id == Gosu::KbR && @game_over
      @ball.reset
      @score.reset
      @game_over = false
    end
  end
end

window = GameWindow.new
window.show
