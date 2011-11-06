require 'rcov/rcovtask'

namespace :rcov do
  
  rcov_options = %w{
    --exclude osx\/objc,gems\/,spec\/,features\/,seeds\/
    --aggregate coverage/coverage.data
  }
  
  Rcov::RcovTask.new(:olib) do |t|
    #rm "coverage/coverage.data" if File.exist?("coverage/coverage.data")
    #t.test_files = FileList['olib_test/**/*_test.rb']
    t.test_files = FileList['olib_test/unit/mlfielib/analysis/*_test.rb']
    t.verbose = true
  end
end

