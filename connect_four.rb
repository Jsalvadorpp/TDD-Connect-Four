require 'io/console'  

class Game
    Rows = 6
    Columns = 7

    def initialize
        @GameBoard = Array.new(Rows) {Array.new(Columns,"-")}  
        initGame()
    end

    def displayBoard

        puts ""
        Rows.times do |row|
            print "|"
            Columns.times do |column|
                print " #{@GameBoard[row][column]} |"
            end
            puts ""
        end
        Columns.times {|column| print "  #{column+1} "}
        puts ""
    end

    def initGame

        gameOver = false
        system("clear")
        puts " *** connect four game *** "
        displayBoard()
        puts ""
        puts "play against the computer"
        print "press any key.."        
        STDIN.getch   
        system("clear")
        
        until gameOver
            displayBoard()
            playerTurn()
            displayBoard()
            #PC_turn()
            puts "PC turn, press any key to continue"
            PC_Turn()
            
        end




    end

    def playerTurn
        
        while true 
            print "choose a column: "
            option = gets.chomp.to_i
            break if option.between?(1,7) && @GameBoard[0][option-1] == "-"
            puts "invalid option, try again"
        end
        makeMove("o",option-1)
        system("clear")
    end
    
    def makeMove(piece,choosenColumn)

        columnArray = []
        Rows.times { |row| columnArray.push(@GameBoard[row][choosenColumn]) }
        lastValidRow = (Rows-1) - columnArray.reverse.find_index("-") 
        puts "row = #{lastValidRow}, column = #{choosenColumn}"
        @GameBoard[lastValidRow][choosenColumn] = piece
    end

    def PC_Turn

        while true 
            puts "choose a column"
            option = gets.chomp.to_i
            break if option.between?(1,7) && @GameBoard[0][option-1] == "-"
            puts "invalid option, try again"
        end
        makeMove("*",option-1)
        system("clear")

    end


end

game = Game.new
game.displayBoard()