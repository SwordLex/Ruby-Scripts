EventHandlers.add(:on_wild_pokemonCreate, :safari_hidden_abilities_switch,
    proc{ |pokemon|
        if $game_switches[63]
            pokemon.ability_index = 2
        end
    }
)