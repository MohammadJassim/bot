class Validator

  attr_accessor :input_command #= []
  attr_accessor :errors #= []

  def initialize(user_input=[])
    self.input_command = user_input
    return false unless user_input
    input_command = user_input
    errors = []
    validate_input
  end

  def validate_input
    valid_length && valid_command && valid_move
  end

  def valid_length
    input_command.length > 2 if input_command
  end

  def valid_command
    (input_command[0].upcase == "PLACE" || input_command[0].upcase == "MOVE") if input_command
  end

  def valid_move
    valid_moves.include?(self.input_command[1]) && valid_moves.include?(self.input_command[2]) if valid_length && input_command
  end

  def valid_moves
    ["0", "1", "2", "3", "4", "N", "S", "E", "W"]
  end

  def placed(input_command)
    input_command.strip.upcase == "PLACED"
  end

  def move(input_command)
    input_command.strip.upcase == "MOVE"
  end

  def edge_move?
    edge = true if self.input_command[1] == 0 || self.input_command[0] == 5 || self.input_command[1] == 5 || self.input_command[1] == 0 
    edge = true if self.input_command[1] == 0 && (self.input_command[3] != "N" && self.input_command[3] != "W") 
    edge = true if self.input_command[2] == 0 && (self.input_command[3] != "N" && self.input_command[3] != "W")
    edge = true if self.input_command[1] == 5 && (self.input_command[3] != "S" && self.input_command[3] != "E")
    edge = true if self.input_command[2] == 5 && (self.input_command[3] != "S" && self.input_command[3] != "E")
  end

  def error_messages
    #errors << "Invalid command: #{input_command}" unless valid_command && !input_command
    #errors << "Invalid command length: #{input_command}.length" unless valid_length && !input_command
    #errors << "Invalid move: #{input_command}" unless valid_move && !input_command
    print(input_command)
    #errors.join(', ') unless errors
  end

end
