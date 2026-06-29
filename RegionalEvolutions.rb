#-------------------------------------------------------------------------------
# Regional forms by map flags
#-------------------------------------------------------------------------------
module RegionalEvolutions
  HISUI   = "HisuiRegion"
  ALOLA   = "AlolaRegion"
  GALAR   = "GalarRegion"
  PALDEA  = "PaldeaRegion"

  def self.current_region
    return nil unless $game_map

    map = $game_map.metadata
    return :hisui   if map&.has_flag?(HISUI)
    return :alola   if map&.has_flag?(ALOLA)
    return :galar   if map&.has_flag?(GALAR)
    return :paldea  if map&.has_flag?(PALDEA)
    return :kanto
  end
end