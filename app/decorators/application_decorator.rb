class ApplicationDecorator < Draper::Decorator

  delegate_all

  include Draper::LazyHelpers

  #
  # String version of our created_at timestamp
  #
  # @return [String]
  def created_at
    self.formatted_date(self.object.created_at)
  end

  protected

  #
  # String version of our date timestamp
  #
  # @return [String]
  def formatted_date(date)
    # very recent is just the time
    if date.try(:>, Time.zone.now.midnight)
      date.strftime('%H:%M %p')
    # this year is month and day
    elsif date.try(:>, Time.zone.now.beginning_of_year)
      date.strftime('%b %-d %H:%M%p')
    else
      date.try(:strftime, '%m/%d/%Y') ||
        I18n.t('defaults.unknown')
    end
  end

  #
  # Overridden here because Draper was failing in the test environment
  # because of a call to super in ApplicationHelper
  #
  # NOTE: * This is just an explicit implementation of LazyHelpers*
  #
  #
  # @param  *args [Array<Mixed>] Args
  # @param  &block [Proc] Content block
  #
  # @return [String] HTML
  def link_to(*args, &block)
    h.link_to(*args, &block)
  end
end
