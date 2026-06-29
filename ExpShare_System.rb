# ==============================================================================
# ExpShare_System
# Manages the EXPSHARE status Pokemon by Pokemon individually.
# ==============================================================================
class Pokemon
  #Returns true if the Pokemon has the EXPSHARE active
  def expshare_active?
    return @expshare_active != false
  end
  
  def expshare_activate
    @expshare_active = true
  end
  
  def expshare_deactivate
    @expshare_active = false
  end
  
  def expshare_toggle
    @expshare_active = !expshare_active?
  end
end