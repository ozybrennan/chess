
class Employee

  attr_reader :name, :title
  attr_accessor :salary, :boss

  def initialize(name, title, salary, boss=nil)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee

  attr_reader :employees

  def initialize(name, title, salary, boss=nil)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    total = 0
    queue = employees
    until queue.empty?
      cur_employee = queue.shift
      if cur_employee.is_a? Manager
        queue += cur_employee.employees
      end
      total += cur_employee.salary
    end

    total * multiplier
  end

  def add_employee(employee)
    employees << employee
    employee.boss = self
  end

end

ned = Manager.new("Ned", "Founder", 1000000)
darren = Manager.new("Darren", "TA Manager", 78000)
shawna = Employee.new("Shawna", "TA", 12000)
david = Employee.new("David", "TA", 10000)
