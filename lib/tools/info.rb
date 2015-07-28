module Tools
  class Info
    class << self
      def ip
        if osx?
          `ifconfig eth0 | grep inet | grep -v inet6 | cut -c 7-17`.strip
        else
          `ifconfig wlan0 | grep inet | grep -v inet6 | cut -c 20-3`.strip
        end
      end
      
      def hostname
        `hostname`.strip
      end

      def thermal
        if osx?
          '?'
        else
          `awk '{printf "%3.1f", $1/1000}' /sys/class/thermal/thermal_zone0/temp`.strip
        end
      end
      
      def platform
        RUBY_PLATFORM
      end

      def osx?
        (/darwin/ =~ platform) != nil
      end
    end
  end
end