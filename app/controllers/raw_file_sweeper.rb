class RawFileSweeper < ActionController::Caching::Sweeper
  observe RawFile
 
  def after_create(raw_file)
    expire_cache_for(raw_file)
  end
 
  def after_update(raw_file)
    expire_cache_for(raw_file)
  end
 
  def after_destroy(raw_file)
    expire_cache_for(raw_file)
  end
 
  private
  def expire_cache_for(raw_file)
    expire_page(:controller => 'raw_files', :action => 'index')
    expire_fragment('all_available_rw_files')
  end
end