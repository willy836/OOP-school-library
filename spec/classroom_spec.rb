require 'yaml'
require './classroom'

describe Classroom do
    before :each do
        @classroom = Classroom.new('Label')
    end

    describe '#initialize' do
    it "sets label" do
        expect(@classroom.label).to eq 'Label'
    end

    it "initializes students to an empty array" do
        expect(@classroom.students).to eq []
      end
    end

    describe '#add_student' do
    it "adds the student to the students array" do
        student = double("Student")
        expect(student).to receive(:classroom=).with(@classroom)
        @classroom.add_student(student)
        expect(@classroom.students).to eq [student]
      end

    it "sets the student's classroom to this classroom" do
      student = double("Student")
      expect(student).to receive(:classroom=).with(@classroom)
      @classroom.add_student(student)
    end
  end
end