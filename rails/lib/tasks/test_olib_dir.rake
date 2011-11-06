namespace :test do

  desc "Test olib source"
  Rake::TestTask.new(:olib) do |t|    
    t.libs << "olib_test"
    t.libs << "olib"
    t.pattern = 'olib_test/**/*_test.rb'
    
    t.verbose = true    
  end

end
