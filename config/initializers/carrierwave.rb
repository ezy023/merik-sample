CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAI4PFY5SQJCS2MFRA',       # required
    :aws_secret_access_key  => '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',       # required
  }
  config.fog_directory  = 'muzerik-songs'                     # required
 end