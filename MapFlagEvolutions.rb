MultipleForms.register(:QUILAVA, {
  "getForm" => proc { |pokemon|
    next if pokemon.form_simple >= 2
    next 1 if RegionalEvolutions.current_region == :hisui
    next 0
  },
})
MultipleForms.copy(:QUILAVA, :DEWOTT, :DARTRIX, :PETILIL, :RUFFLET, :GOOMY, :BERGMITE)

MultipleForms.register(:MIMEJR, {
  "getForm" => proc { |pokemon|
    next 1 if RegionalEvolutions.current_region == :galar
    next 0
  },
})

MultipleForms.register(:CUBONE, {
  "getForm" => proc { |pokemon|
    next 1 if RegionalEvolutions.current_region == :alola
    next 0
  },
})
MultipleForms.copy(:CUBONE, :PIKACHU, :EXEGGCUTE)

MultipleForms.register(:RATATA, {
  "getFormOnEggCreation" => proc { |pokemon, parent|
    
    region = RegionalEvolutions.current_region
    case region
    when :kanto
      form = 0
    when :alola
      case pokemon.species
      when :RATTATA, :SANDSHREW, :VULPIX, :DIGLETT, :MEOWTH, :GEODUDE, :GRIMER
            form = 1
      end
    when :galar
      case pokemon.species
      when :PONYTA, :SLOWPOKE, :FARFETCHD, :ARTICUNO, :ZAPDOS, :MOLTRES, :CORSOLA, :ZIGZAGOON, :YAMASK, :STUNFISK
        form = 1
      when :MEOWTH, :DARUMAKA
        form = 2
      end
    when :hisui     
      case pokemon.species
      when :GROWLITHE, :VOLTORB, :QWILFISH, :SNEASEL, :ZORUA
        form = 1
      end
    when :paldea
      case pokemon.species
          when :WOOPER
            form = 1
          when :TAUROS
            form = (parent.form == 0) ? 1 : parent.form
          end
    end
    next form if form > 0 && GameData::Species.get_species_form(pokemon.species, form).form == form
  }
})
MultipleForms.copy(:RATTATA, :SANDSHREW, :VULPIX, :DIGLETT, :MEOWTH, :GEODUDE, :GRIMER,      # Alolan
                   :PONYTA, :FARFETCHD, :CORSOLA, :ZIGZAGOON, :YAMASK, :STUNFISK,            # Galarian                                   
                   :SLOWPOKE, :ARTICUNO, :ZAPDOS, :MOLTRES,                                  # Galarian (DLC)
                   :GROWLITHE, :VOLTORB, :QWILFISH, :SNEASEL, :ZORUA,                        # Hisuian
                   :TAUROS, :WOOPER                                                          # Paldean
                  ) 