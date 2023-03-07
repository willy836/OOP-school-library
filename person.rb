require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def of_age?
    @age >= 18
  end

  private :of_age?

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end
end

# Testing
person = Person.new(22, 'maximilianus')
p person.correct_name
person = Person.new(22, 'maximilianus')
capitalized_person = CapitalizeDecorator.new(person)
p capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
p capitalized_trimmed_person.correct_name
