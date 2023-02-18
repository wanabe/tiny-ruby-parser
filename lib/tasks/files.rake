file "parser.rb" => ["parser.peg"] do
  system("bundle exec packcr -l rb parser.peg")
end

file "parser.c" => ["parser.peg"] do
  system("bundle exec packcr -l c parser.peg")
end
file "tiny_ruby_parser.so" => ["parser.c"] do
  system({"MAKE" => "1"}, "bundle exec ruby -I. parser.rb")
end