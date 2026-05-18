require "tzinfo"
require "time"

module TimezoneAbbreviationFilter
  def format_in_timezone(input, timezone_name, format = "%B %-d, %Y at %-I:%M %p %Z")
    return input.to_s if timezone_name.to_s.empty?

    time =
      if input.respond_to?(:to_time)
        input.to_time
      else
        Time.parse(input.to_s)
      end

    timezone = TZInfo::Timezone.get(timezone_name.to_s)
    local_time = timezone.utc_to_local(time.utc)
    local_time.strftime(format.sub("%Z", timezone.period_for_utc(time.utc).abbreviation.to_s))
  rescue StandardError
    if input.respond_to?(:strftime)
      input.strftime(format)
    else
      input.to_s
    end
  end

  def timezone_abbreviation(input, timezone_name)
    return timezone_name.to_s if timezone_name.to_s.empty?

    time =
      if input.respond_to?(:to_time)
        input.to_time
      else
        Time.parse(input.to_s)
      end

    timezone = TZInfo::Timezone.get(timezone_name.to_s)
    timezone.period_for_utc(time.utc).abbreviation.to_s
  rescue StandardError
    timezone_name.to_s
  end
end

Liquid::Template.register_filter(TimezoneAbbreviationFilter)
