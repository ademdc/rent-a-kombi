module ProfileHelper
  def reservation_status(status)
    status ? I18n.t('profile.confirmed').upcase : I18n.t('profile.pending').upcase
  end
end
