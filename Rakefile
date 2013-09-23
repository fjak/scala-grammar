require_relative 'lib/pprule'
require_relative 'lib/deffile'

ppfile = File.join("syntax", "Scala.pp")
gen_ppfile = File.join("syntax", "Scala.generated.pp")

file "pp" => [ppfile, gen_ppfile] do |t|
  ppfile_rules = PPRule.rules_from(ppfile)
  gen_rules = PPRule.rules_from(gen_ppfile)
  merged = PPRule.merge(ppfile_rules, gen_rules)
  puts PPRule.to_table(merged)
end

deffile = File.join("include", "Scala.def")

file "def" => [deffile] do |t|
  prods = DefFile.read_productions(deffile)
  prods.delete("LAYOUT")
  sorted_prods = prods.to_a.sort
  sugscdef = DefFile.sprint_sugdef(sorted_prods, "Scala")
  puts File.read(deffile).gsub(/[ \t]+$/, "")
  puts ""
  puts sugscdef
end

strfile = File.join("include", "Scala.str")

file "str" => [strfile] do |t|
  puts File.read(strfile)
end
