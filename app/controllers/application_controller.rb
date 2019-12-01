class ApplicationController < ActionController::Base
  before_action :set_locale

  def locale
    redirect_to root_path, notice: t(:locale_change, language: t("languages.#{I18n.locale}"))
  end

  private

    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
      parsed_locale = params[:locale]
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end

    def default_url_options
      { locale: I18n.locale }
    end

end
