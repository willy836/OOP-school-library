require 'json'

# rubocop:disable Metrics

module PreservePeopleData
  def store_people(people)
    teachers_file = './data_store/teachers.json'
    students_file = './data_store/students.json'

    # Read the contents of the file and handle empty file / invalid JSON cases
    begin
      teachers_data = File.exist?(teachers_file) ? JSON.parse(File.read(teachers_file)) : []
      students_data = File.exist?(students_file) ? JSON.parse(File.read(students_file)) : []
    rescue JSON::ParserError, Errno::ENOENT
      teachers_data = []
      students_data = []
    end

    people.each do |individual|
      if individual.is_a?(Student)
        # Check if student already exists before adding
        existing_student = students_data.find { |student| student['name'] == individual.name }
        if existing_student.nil?
          students_data << { age: individual.age, classroom: individual.classroom,
                             name: individual.name, parent_permission: individual.parent_permission }
        end
      end
      next unless individual.is_a?(Teacher)

      # Check if teacher already exists before adding
      existing_teacher = teachers_data.find { |teacher| teacher['name'] == individual.name }
      if existing_teacher.nil?
        teachers_data << { specialization: individual.specialization, age: individual.age, name: individual.name }
      end
    end

    File.write(teachers_file, JSON.pretty_generate(teachers_data))
    File.write(students_file, JSON.pretty_generate(students_data))
  end

  def load_people
    teachers_file = './data_store/teachers.json'
    students_file = './data_store/students.json'

    return [] unless File.exist?(teachers_file) && File.exist?(students_file)

    teachers_data = File.zero?(teachers_file) ? [] : JSON.parse(File.read(teachers_file))
    students_data = File.zero?(students_file) ? [] : JSON.parse(File.read(students_file))

    teachers = teachers_data.map do |teacher|
      Teacher.new(teacher['specialization'], teacher['age'], teacher['name'])
    end
    students = students_data.map do |student|
      Student.new(student['age'], student['classroom'], student['name'], student['parent_permission'])
    end

    teachers + students
  end
end

# rubocop:enable Metrics
