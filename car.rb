def assert(val)
  unless val
    STDERR.puts 'Failed'
    STDERR.puts caller.first(3).join("\n")
    exit 1
  end
end

class Car
  attr_accessor :colour, :body, :engine_type
  def initialize(opts)
    opts.each do |key,value|
      next unless respond_to?(key, "#{key}=")
      send("#{key}=", value)
    end
  end
end






assert defined? Car

c1 = Car.new(colour: :red)
assert c1.colour == :red
c1.colour = :blue
assert c1.colour == :blue

c2 = Car.new(body: 'hatchback')
assert c2.body == 'hatchback'
c2.body = :cabrio
assert c2.body == :cabrio

c3 = Car.new(engine_type: :diesel)
assert c3.engine_type == :diesel
c3.engine_type = :gas
assert c3.engine_type == :gas
