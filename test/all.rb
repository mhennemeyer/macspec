dir = File.dirname(__FILE__)
Dir[File.expand_path("#{dir}/**/*.rb")].uniq.each do |file|
  if (file =~ /\/\w+_test\.rb$/)
    require file
  end
end