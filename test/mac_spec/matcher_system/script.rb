# parses all test files (test_...rb or ..._tests.rb) below current folder 
# and replaces all occurences of
# def test_whatever
# with 
# $keyword "whatever" do
# $keyword defaults to 'test'

keyword = "test"

dir = File.dirname(__FILE__)
Dir[File.expand_path("#{dir}/**/*.rb")].uniq.each do |file|
  if ((file =~ /\/test_\w+\.rb$/) || (file =~ /\w+_tests\.rb$/)) && (file !~ /\/test_helper\.rb$/)
    puts file
    File.open(file,File::RDWR) do |f|
      new_lines = []
      old_lines = f.readlines
      old_lines.each do |line|
        if line =~ /\A(\s*)def\s+test_(.*)\Z/
          space = $1
          desc = $2.gsub(/_/, " ")
          line = "#{space}#{keyword} \"#{desc}\" do"
        end
        new_lines << line
      end
      f.pos = 0
      f.puts new_lines
    end
  end
end