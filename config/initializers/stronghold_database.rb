STRONGHOLD_DB = YAML::load(ERB.new(File.read(Rails.root.join("config","stronghold_database.yml"))).result)[Rails.env]