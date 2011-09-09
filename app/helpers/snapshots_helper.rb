module SnapshotsHelper

  def set_snap(snapshot)
  self.current_snap = snapshot
  end

  def current_snap=(snapshot)
    @current_snap = snapshot

  end

  def current_snaps
    @current_snap
  end

end
