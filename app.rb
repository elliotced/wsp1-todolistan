require 'debug'
require "awesome_print"

class App < Sinatra::Base

    def db
      return @db if @db

      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    # Routen / index
    get '/' do
      @todos = db.execute('SELECT * FROM todos')
      p @todos
      erb(:"index")
    end

    # Routen tar bort ToDo med id
    post '/:id/delete' do | id |
      db.execute('DELETE FROM todos WHERE id=?', id)
      redirect('/')
    end
end