
require 'pry'

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)

    new_song = self.new
    new_song.id = row[0]
    new_song.name = row[1]
    new_song.grade = row[2]
    new_song

  end

  def self.all
    sql = <<-SQL
      SELECT * FROM students
      SQL
      DB[:conn].execute(sql).map do |row|
        binding.pry
        self.new_from_db(row)
      end
    

  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
