class GameCell
  attr_reader :content

  def initialize
    @content = nil
    @hit = false
  end

  def hit?
    @hit
  end

  def hit
    @hit = true
  end

  def add(data)
    @content = data if @content == nil
  end

end
