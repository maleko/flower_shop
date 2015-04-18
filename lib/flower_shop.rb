#
# This is the main file for the Automaton application.  It expects to be called:
#
#   Automaton.application.run
#

require 'highline'
require 'cli-console'
require 'awesome_print'

module FlowerShop

  class << self

    def application
      @application ||= FlowerShop::Application.new
    end

  end

  class Application

    private
    extend CLI::Task

    public

    def initialize
      #puts "Initialising Board....."
      #@board = Automaton::Board.new
      #puts "Initialising Automaton......."
      #@automaton = Automaton::Daneel.new @board
    end

    #usage 'Usage: place x v f (i.e. place 0 0 north)'
    #desc  'Places your automaton on the board'
    #def place(params)
      #puts'placing'
      #@automaton.placed_at(params[0].to_i, params[1].to_i, params[2].downcase)
      #puts @automaton.report
    #end

  end

end

io = HighLine.new
flower_shop = FlowerShop::Application.new
console = CLI::Console.new(io)

#console.addCommand('place',   automaton.method(:place),   'Places automaton. i.e. "place 0 0 north"')

console.addHelpCommand('help', 'Help')
console.addExitCommand('exit', 'Exit from program')

console.addAlias('q',       'exit')

console.start("👾", [''])
