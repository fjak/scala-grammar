module DefFile
  def self.read_productions(deffile)
    prods = Set.new
    File.open(deffile).each do |l|
      mtch = /->\s*([a-zA-Z0-9_-]+)/.match(l)
      unless mtch.nil?
        prods << mtch[1]
      end
    end
    prods
  end

  def self.sprint_sugdef(productions, lang)
    langified_prods = productions.map do |p|
      if lexical? p
        "#{lang.upcase}-#{p}"
      else
        "#{lang}#{p}"
      end
    end
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

  private

  def self.lexical?(s)
    (/[a-z]/ =~ s).nil?
  end
end
