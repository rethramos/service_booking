# Return an array to customize <option> text, `value` and other HTML attributes
CountrySelect::FORMATS[:short_name] = lambda do |country|
  [
    country.iso_short_name,
    country.iso_short_name,
    {
      'data-country-code' => country.country_code,
      'data-alpha3' => country.alpha3
    }
  ]
end