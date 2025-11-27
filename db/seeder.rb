require 'sqlite3'
require_relative '../config'

class Seeder

  def self.seed!
    puts "Using db file: #{DB_PATH}"
    puts "🧹 Dropping old tables..."
    drop_tables
    puts "🧱 Creating tables..."
    create_tables
    puts "🍎 Populating tables..."
    populate_tables
    puts "✅ Done seeding the database!"
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS todos')
  end

  def self.create_tables
    db.execute('CREATE TABLE todos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL, 
                description TEXT)')
  end

  def self.populate_tables
    db.execute('INSERT INTO todos (id, title, description) VALUES (1, "Köp mjölk", "3 lite mellanmjölk, eko")')
    db.execute('INSERT INTO todos (id, title, description) VALUES (2, "Köp julgran", "En rödgran")')
    db.execute('INSERT INTO todos (id, title, description) VALUES (3, "Pynta gran", "Glöm inte lamporna i granen och tomten")')
  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new(DB_PATH)
      db.results_as_hash = true
      db
    end
  end

end

Seeder.seed!