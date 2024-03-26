class Round
    attr_reader :deck,
                :turns

    def initialize(deck)
        @deck = deck
        @turns = []
    end

    def current_card
        @deck.cards.first
    end

    def take_turn(guess)
        new_turn = Turn.new(guess, current_card)
        @turns << new_turn
        @deck.cards.rotate!
        new_turn
    end

    def number_correct
        (@turns.select do |turn|
            turn.correct?
        end).length
    end
        
    def number_correct_by_category(category)
        (@turns.select do |turn|
            turn.correct? && turn.card.category == category
        end).length
    end

    def percent_correct
        ((number_correct.to_f / @turns.length) * 100).round(1)
    end

    def percent_correct_by_category(category)
        category_total = (@turns.select do |turn|
            turn.card.category == category
        end).length

        ((number_correct_by_category(category).to_f / category_total) * 100).round(1)
    end
end