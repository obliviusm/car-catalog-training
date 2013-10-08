require 'pry'

def assert(val)
  unless val
    STDERR.puts 'Failed'
    STDERR.puts caller.first(3).join("\n")
    exit 1
  end
end

class Car
  ATTRIBUTES = %w[colour body engine_type]

  def method_missing(method, *args, &block)
    if respond_to? method
      if args.length == 0
        instance_variable_get(:"@#{method}")
      else
        instance_variable_set(:"@#{method.to_s.gsub('=', '')}", args.first)
      end
    else
      super
    end
  end

  def initialize(opts={}, &block)
    opts.each do |key,value|
      send("#{key}=", value)
    end
    if block_given?
      if block.arity == 0
        instance_eval &block
      else
        instance_exec self, &block
      end
    end
  end

  def respond_to? arg
    return true if ATTRIBUTES.include? arg.to_s
    ATTRIBUTES.each { |a| return true if "#{a}=" == arg.to_s }
    super
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

c4 = begin
       Car.new
     rescue
       false
     end
assert c4

c5 = Car.new do |c|
  c.colour = :green
  c.body   = :pretty
  c.engine_type = :electro
end

assert c5.colour  == :green &&
        c5.body   == :pretty &&
        c5.engine_type == :electro

c6 = Car.new do
  colour :black
  body   :batmobile
  engine_type :neutrino
end

assert c6.colour == :black && c6.body == :batmobile && c6.engine_type == :neutrino
