def assert(val)
  unless val
    STDERR.puts 'Failed'
    STDERR.puts caller.first(3).join("\n")
    exit 1
  end
end

class Car
  attr_reader :colour, :body
  def initialize(opts)
    @colour = opts[:colour]
    @body   = opts[:body]
  end
end






assert defined? Car

c1 = Car.new(colour: :red)
assert c1.colour == :red

c2 = Car.new(body: :hatchback)
assert c2.body == :hatchback
