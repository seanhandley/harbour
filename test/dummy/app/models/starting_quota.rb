module StartingQuota
  class << self
    def [](key)
      settings[key]
    end

    private

    def settings
      {
        "standard" => {
          "compute" => {
            "instances" => 10,
            "cores"     => 10,
            "ram"       => 20480
          },
          "volume" => {
            "volumes"   => 4,
            "snapshots" => 4,
            "gigabytes" => 40
          },
          "network" => {
            "floatingip"          => 1,
            "router"              => 1,
            "security_group_rule" => 100,
            "security_group"      => 10,
            "network"             => 10,
            "port"                => 10,
            "subnet"              => 10
          }
        }
      }
    end
  end
end
