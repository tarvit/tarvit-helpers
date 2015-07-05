class Array

  def info_by_rule(info, &rule)
    counts = self.group_by{|x|
      rule.(x)
    }.to_a.map{|x|
      x[1] = info.(x[1])
      x
    }
    Hash[counts]
  end

  def count_by_rule(&rule)
    info_by_rule(->(x){
      x.count
    }){|x|
      rule.(x)
    }
  end

end
