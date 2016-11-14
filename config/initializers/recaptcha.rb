Recaptcha.configure do |config|
  if Rails.env.production?
    config.public_key  = '6Ld9-dISAAAAAJrSexRiPAoY7gPb5NLYtRetNTH2'
    config.private_key = '6Ld9-dISAAAAAEy0UhlHAFqjLVEGgCJQhmXdUu7s'
  else
    config.public_key  = '6Ld_-dISAAAAAO9X81b-T4u-0szxdTI-4WUmA77g'
    config.private_key = '6Ld_-dISAAAAAGRty_1LkHXIr8AJR8_UelXfbw9z'
  end
end
