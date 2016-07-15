class Client
  attr_reader(:first_name, :last_name, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @id = attributes[:id]
  end

  define_method(:==) do |another_client|
    self.first_name() == another_client.first_name() &&
    self.last_name() == another_client.last_name()
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      first_name = client.fetch('first_name')
      if first_name.include? "ß"
        first_name = first_name.gsub(/ß/, "'")
      end
      last_name = client.fetch('last_name')
      if last_name.include? "ß"
        last_name = last_name.gsub(/ß/, "'")
      end
      id = client.fetch('id').to_i()
      clients.push(Client.new({first_name: first_name, last_name: last_name}))
    end
    clients
  end

  define_method(:save) do
    if @first_name.include? "'"
      @first_name = @first_name.gsub(/'/, "ß")
    end
    if @last_name.include? "'"
      @last_name = @last_name.gsub(/'/, "ß")
    end
    result = DB.exec("INSERT INTO clients (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name, @first_name)
    if @first_name.include? "'"
      @first_name = @first_name.gsub(/'/, "ß")
    end
    @last_name = attributes.fetch(:last_name, @last_name)
    if @last_name.include? "'"
      @last_name = @last_name.gsub(/'/, "ß")
    end
    @id = self.id()

    DB.exec("UPDATE clients SET first_name = '#{@first_name}' WHERE id = #{@id};")
    DB.exec("UPDATE clients SET last_name = '#{@last_name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()}")
  end
end
