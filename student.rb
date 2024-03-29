require_relative './person'

class Student < Person
  attr_reader :classroom, :parent_permission

  def initialize(age, classroom, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
