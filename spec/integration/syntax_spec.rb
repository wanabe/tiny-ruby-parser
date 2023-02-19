require "rspec"
require "rspec-parameterized"

def get_tree(*args, **env)
  unless env.empty?
    env = env.to_h {|*kv| kv.map!(&:to_s) }
  end
  IO.pipe do |i, o|
    system(env, *args, out: o)
    o.close
    tree = i.read
    tree.gsub!(/(@ NODE.*\(id: )[0-9]*,/) { $1 + "***," }
    tree.gsub!(/.*###########################################################\n+/m, "")
    tree
  end
end

def get_tiny_ruby_parser_tree(src, **env)
  get_tree("ruby", "-I", ".", "parser.rb", src, **env)
end

def get_ruby_tree(src)
  get_tree("ruby", "--dump=parsetree", "-e", src)
end

RSpec.describe "tyny-ruby-parser" do
  where(:src) do
    [
      "123",
      "'123'",
      "\"123\"",
      "p 1",
      "a = 1",
      "1 + 2 * 3 - 4 / 5",
      "def foo; end",
      "def foo(a) end",
      "def foo(a); b = 1; end",
      "class Foo; def foo; end end",
      "def foo(*) end",
      "def foo(*a) end",
      "def foo(a, *b) end",
      "def foo(**) end",
      "def foo(**a) end",
      "def foo(a, **b) end",
      "def foo(*a, **b) end",
      File.read(__FILE__)[/\A(.*\n?){,4}/] + "end",
    ]
  end

  with_them do
    it do
      expected = get_ruby_tree(src)
      expect(get_tiny_ruby_parser_tree(src)).to eq(expected)
      expect(get_tiny_ruby_parser_tree(src, "EXT": "1")).to eq(expected)
    end
  end
end
