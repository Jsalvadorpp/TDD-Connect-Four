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
            break if checkCombination("o")
            displayBoard()
            #PC_turn()
            puts "PC turn, press any key to continue"
            PC_Turn()
            break if checkCombination("*")
            
        end

        player = gameResults()
        puts " *****************************"
        puts " ***      #{player} WON    ***"
        puts " *****************************"



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

    def checkCombination(piece)

        #check  horizontal cells
        Rows.times do |row|
            horizontalCells = []
            Columns.times { |cell| horizontalCells.push(@GameBoard[row][cell]) }
            return true if checkCells(horizontalCells,piece)
        end

        #check vertical cells
        Columns.times do |column|
            columnCells = []
            Rows.times { |cell| columnCells.push(@GameBoard[cell][column])}
            return true if checkCells(columnCells,piece)
        end

        #check left diagonal cells 
        Rows.times do |row|
            diagonalLeftCells = []
            column = 0
            (row...Rows).each do |x|
                diagonalLeftCells.push(@GameBoard[x][column])
                column+=1
            end
            return true if checkCells(diagonalLeftCells,piece)
        end

        (1...Columns).each do |column|
            diagonalLeftCells = []
            row = 0
            (column...Columns).each do |y|
                diagonalLeftCells.push(@GameBoard[row][y])
                row += 1
            end
            return true if checkCells(diagonalLeftCells,piece)
        end

        #check right diagonal cells
        Rows.times do |row|
            diagonalRightCells = []
            column = Columns - 1
            (row...Rows).each do |x|
                diagonalRightCells.push(@GameBoard[x][column])
                column-=1
            end
            return true if checkCells(diagonalRightCells,piece)
        end

        (Columns-2).downto(0) do |column|
            diagonalRightCells = []
            row = 0
            column.downto(0) do |y|
                diagonalRightCells.push(@GameBoard[row][y])
                row += 1
            end
            return true if checkCells(diagonalRightCells,piece)
        end
      
        return false
    end

    def checkCells(cellsList,piece)
        return false unless cellsList.any?(piece)
        count = 0
        cellsList.each do |cell|
            count = (cell == piece)? (count+1):0
            return true if count == 4
        end
        return false
    end

    def gameResults
        return "You" if checkCombination("o")
        return "PC" if checkCombination("*")
    end


end

game = Game.new

