require 'yaml'
require './teacher'

describe Teacher do
  before :each do
    @teacher = Teacher.new('Astronomy', 45, 'Jane Doe')
  end

  describe '#initialize' do
    it "sets the teacher's specialization" do
      expect(@teacher.instance_variable_get(:@specialization)).to eq 'Astronomy'
    end

    it "sets teacher's age" do
      expect(@teacher.age).to eq 45
    end

    it "sets teacher's name" do
      expect(@teacher.name).to eq 'Jane Doe'
    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(@teacher.can_use_services?).to eq true
    end
  end
end
