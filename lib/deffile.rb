module DefFile
  def self.read_productions(deffile)
    prods = Set.new
    File.open(deffile).each do |l|
      mtch = /->\s*(\w+)/.match(l)
      unless mtch.nil?
        prods << mtch[1]
      end
    end
    prods
  end

  def self.sprint_sugdef(productions, lang)
    langified_prods = productions.map {|p| "#{lang}#{p}"}
    prod_mappings = []
    productions.each_index do |i|
      prod_mappings << sprintf("%-37s => %s", productions[i], langified_prods[i])
    end
    sugdef =  "module org/sugarj/languages/#{lang}\n"
    sugdef << "imports #{lang}\n"
    sugdef << "\t[ "
    sugdef << prod_mappings.join("\n\t  ")
    sugdef << " ]\n"
    sugdef
  end
end
