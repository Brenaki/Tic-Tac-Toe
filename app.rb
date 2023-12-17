# Lib of color
require 'colorize'

def clear
    system("cls")
end
def pause
    print "\n"
    system("pause")
end

def instructions(p1, p2)
    board = [1,2,3,4,5,6,7,8,9]
    puts "This will be Tic Tac Toe board:\n\n"
    drawGame(board)
    puts "\n*Instructions:".colorize(:background => :yellow)
    puts "1. Insert the spot number(1-9) to put your sign\n2. #{p1} will go first\n\n#{p1}'s sign will be - X\n#{p2}'s sign will be - O"
    pause()
end

# Draw game
def drawGame(board)
    puts "\t #{board[0]} | #{board[1]} | #{board[2]}"
    puts "\t---|---|---"
    puts "\t #{board[3]} | #{board[4]} | #{board[5]}"
    puts "\t---|---|---"
    puts "\t #{board[6]} | #{board[7]} | #{board[8]}"
end 

# Tic Tac Toe
def game
    clear()
    print "Enter player one name: "
    p1 = gets.chomp.capitalize
    print "Enter player two name: "
    p2 = gets.chomp.capitalize
    instructions(p1, p2)
    board = Array.new(9, " ")
    begin
      clear()
      drawGame(board)
      passed = false
      begin
        print "#{p1}: "
        n = gets.to_i - 1
        if(board[n] == " ")
            board[n] = "X"
            passed = true
        else
            print "\a"
            puts "These spaces have already been filled".red
            sleep(2)
        end
      end while passed == false
      drawGame(board)
      if(finished(board, p1))
        break
      end
      pause()
      clear()
      drawGame(board)
      passed = false
      begin
        print "#{p2}: "
        n = gets.to_i - 1
        if(board[n] == " ")
            board[n] = "O"
            passed = true
        else
            print "\a"
            puts "These spaces have already been filled".red
            sleep(2)
        end
      end while passed == false
      drawGame(board)
      if(finished(board, p2))
        break
      end
      pause()
    end while !finished(board, p= " ")
    again()
end

# Play Again
def again()
    clear()
    puts "*******************\n1 - Play Again     \n2 - Return to menu \n*******************".colorize(:background => :blue)
    print "Choose an option: "
    choose = gets.chomp.to_i
    case choose
    when 1
        game()
    when 2
        clear()
    else
        print "\a"
        puts "Invalid option!".red
        puts "You will be directed to the menu".yellow
        sleep(3)
        clear()
    end
end

# Won or Draw?
def finished(board, p)
    if(won?(board))
        puts "\n#{p} won!".green
        pause()
        return true
    elsif(draw?(board))
        puts "\nUnfortunately the game was a draw".yellow
        pause()
        return true
    else
        return false
    end
end

WIN_COMP = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
]

def positionTaken?(index, board)
    !(board[index].nil? || board[index] == " ")
end
def won?(board)
    WIN_COMP.detect do |comb|
        board[comb[0]] == board[comb[1]] &&
        board[comb[1]] == board[comb[2]] &&
        positionTaken?(comb[0], board)
    end
end

def draw?(board)
    board.all?{
        |i| i == "X" || i == "O"
    }
end

# Menu/Main
def menu()
    exit = false
    begin
        clear()
        puts "**** Welcome to Tic Tac Toe ****\n1 - Play                        \n2 - Credits                     \n3 - Quit                        \n********************************".colorize(:background => :blue)
        print "Choose an option: "
        choose = gets.chomp.to_i
        case choose
        when 1
            game()
        when 2
            credits()
            pause()
        when 3
            puts "Thank you for played!".green
            exit = true
        else
            print("\a")
            puts "Invalid option! Try again, please".red
            pause()
        end
    end while exit == false
end

def credits()
clear()
puts "\n=====================================\n\t     Tic Tac Toe\n=====================================".green
puts "\nDeveloped by:\n\t- Victor Cerqueira (RjP)".yellow
puts "\nResouces Used:\n\t- Ruby+Devkit 3.2.2-1\n\t- Colorize Library".yellow
puts "\n=====================================\n\tThank you for played!\n=====================================".green
end

menu()