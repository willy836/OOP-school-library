require 'yaml'
require './student'
require './classroom'

describe Student do
    before :each do
      @classroom = Classroom.new('Class A')
      @student = Student.new(17, @classroom, 'Mercy', true)
    end
  
    describe '#initialize' do
      it "returns student's age" do
        expect(@student.age).to eq 17
      end
  
      it "returns student's name" do
        expect(@student.name).to eq 'Mercy'
      end
  
      it "returns student's classroom" do
        expect(@student.classroom).to eq @classroom
      end
    end
  
    describe '#play_hooky' do
      it "returns a message indicating the student is playing hooky" do
        expect(@student.play_hooky).to eq '¯(ツ)/¯'
      end
    end
  
    describe '#classroom' do
      it "returns student's classroom" do
        expect(@student.classroom).to eq @classroom
      end
    
    it "adds the student to the classroom's student list" do
      expect(@classroom.students).not_to include(@student)
      @student.classroom = @classroom
      expect(@classroom.students).to include(@student)
    end
  
  
      it "doesn't add the student to the same classroom twice" do
        @student.classroom = @classroom
        expect(@classroom.students.count(@student)).to eq 1
      end
    end
  end