class Employee
  attr_accessor :name, :title, :salary, :boss
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end
end

class Manager < Employee

  attr_accessor :underlings

  def initialize(name, title, salary, boss, underlings)
    super(name, title, salary, boss)
    @underlings = underlings
  end

  def bonus(multiplier)
    subordinate_sum * multiplier
  end

  def subordinate_sum
    return self.salary if @underlings.nil?
    sum = 0
    @underlings.each do |underling|
      if underling.title == "slave"
        sum += underling.salary
      else
        sum += underling.salary + underling.subordinate_sum
      end
    end

    sum
  end

end
