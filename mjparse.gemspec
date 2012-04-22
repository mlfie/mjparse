description = "parse and calculate a point of mahjang agari"
  s.email = "miragino@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "VERSION",
     "lib/mjparse.rb",
     "lib/mjparse/analysis/kyoku.rb",
     "lib/mjparse/analysis/mentsu.rb",
     "lib/mjparse/analysis/mentsu_resolver.rb",
     "lib/mjparse/analysis/pai.rb",
     "lib/mjparse/analysis/score_calculator.rb",
     "lib/mjparse/analysis/tehai.rb",
     "lib/mjparse/analysis/teyaku_decider.rb",
     "lib/mjparse/analysis/yaku_judger.rb",
     "lib/mjparse/analysis/yaku_judger_man.rb",
     "lib/mjparse/analysis/yaku_judger_one.rb",
     "lib/mjparse/analysis/yaku_judger_three_six.rb",
     "lib/mjparse/analysis/yaku_judger_two.rb",
     "lib/mjparse/analysis/yaku_specimen.rb",
     "test/analysis/mentsu_resolver_test.rb",
     "test/analysis/score_calculator_test.rb",
     "test/analysis/yaku_judger_man_test.rb",
     "test/analysis/yaku_judger_one_test.rb",
     "test/analysis/yaku_judger_test.rb",
     "test/analysis/yaku_judger_three_six_test.rb",
     "test/analysis/yaku_judger_two_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = "http://github.com/ginok/mjparse"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "parse and calculate a point of mahjang agari"
  s.test_files = [
    "test/analysis/mentsu_resolver_test.rb",
     "test/analysis/score_calculator_test.rb",
     "test/analysis/yaku_judger_man_test.rb",
     "test/analysis/yaku_judger_one_test.rb",
     "test/analysis/yaku_judger_test.rb",
     "test/analysis/yaku_judger_three_six_test.rb",
     "test/analysis/yaku_judger_two_test.rb",
     "test/mjparse_test.rb",
     "test/test_helper.rb"
  ]

  s.add_dependency('renum')

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
