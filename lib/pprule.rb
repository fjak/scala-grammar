class PPRule
  attr_accessor :name, :rule

  def initialize(name, rule)
    @name = name
    @rule = rule
  end

  def self.from(line)
     mtch = /^\s*(\S+)\s*--\s*(.+)$/.match(line)
     unless (mtch.nil?) then
       rule = mtch[2].strip
       rule = rule.chop if rule[-1] == ","
       PPRule.new(mtch[1], rule)
     else
       nil
     end
  end

  def self.rules_from(ppfile)
    rules = {}
    File.open(ppfile).each do |l|
      pprule = PPRule.from(l)
      rules[pprule.name] = pprule unless pprule.nil? || rules.key?(pprule.name)
    end
    rules
  end

  def self.merge(hi_prio, low_prio)
    merged = hi_prio.values
    low_prio.each do |k, v|
      merged << v unless hi_prio.key?(k)
    end
    merged
  end

  def to_s
    "#{@name} -- #{@rule}"
  end

  def self.to_table(rules)
    out = "[\n"
    out << "  "
    out << rules.join(",\n  ")
    out << "\n]"
  end
end
