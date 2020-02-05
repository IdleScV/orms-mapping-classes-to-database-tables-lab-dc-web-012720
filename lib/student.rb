class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name_string, grade_integer, id='nil')
    @name = name_string
    @grade = grade_integer
    @id = id
  

  end

  def self.create_table
    sql_create_table = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL
    DB[:conn].execute(sql_create_table)
  end
  

  def self.drop_table 
    sql_drop_table = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql_drop_table)
  end

  def save 
    sql_save = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL
    DB[:conn].execute(sql_save, self.name, self.grade)
    @id = DB[:conn].execute("SELECT LAST_INSERT_ROWID()")[0][0]
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end
end
