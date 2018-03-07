# Represents an open issue on Honeybadger
class Issue
  def initialize(args = {})
    @args = args
  end

  delegate :[], to: :@args

  def open?
    !self[:resolved]
  end

  def notices_count
    self[:notices_count].to_i
  end
end
