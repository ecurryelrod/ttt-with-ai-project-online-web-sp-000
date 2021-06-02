class Game
    attr_accessor :board, :player_1, :player_2
    WIN_COMBINATIONS = [
        [0, 1, 2], 
        [3, 4, 5], 
        [6, 7, 8], 
        [0, 3, 6], 
        [1, 4, 7], 
        [2, 5, 8], 
        [0, 4, 8], 
        [2, 4, 6]
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        @board.turn_count % 2 == 0 ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.find do |winner|
            @board.cells[winner[0]] == @board.cells[winner[1]] && 
            @board.cells[winner[1]] == @board.cells[winner[2]] &&
            (@board.cells[winner[0]] == "X" || @board.cells[winner[0]] == "O")
        end 
    end 

    def draw?
        @board.full? && !won?
    end 

    def over?
        won? || draw? || @board.full?
    end 

    def winner 
        @board.cells[won?[0]] if won?
    end 
    
    def turn
        puts "Please enter 1-9:"
        @board.display
        input = current_player.move(@board)
        if !@board.valid_move?(input)
            puts "Invalid move."
            turn
            @board.display
        else 
            @board.update(input, current_player)
        end
    end

    def play
        while !over?
            turn 
        end
        if won? 
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end 
end 