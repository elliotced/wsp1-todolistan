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

    # Routen visar edit ToDo med id
    get '/:id/edit' do | id |
      @todo = db.execute('SELECT * FROM todos WHERE id = ?', id).first
      erb(:"edit")
    end

    # Routen updaterar ToDo med id
    post '/:id/update' do | id |
      title = params["title"]
      description = params["description"]

      db.execute("UPDATE todos SET title =?, description=? WHERE id =?", [title, description, id])

      redirect("/")
    end

    # Routen tar bort ToDo med id
    post '/:id/delete' do | id |
      db.execute('DELETE FROM todos WHERE id=?', id)
      redirect('/')
    end
end