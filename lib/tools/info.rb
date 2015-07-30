module Tools
  class Info
    class << self
      def ip
        if osx?
          %x('/sbin/ifconfig').scan(/\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b/)[1].strip
        else
          `ifconfig wlan0 | grep inet | grep -v inet6 | cut -c 20-31`.strip
        end
      end
      
      def hostname
        `hostname`.strip
      end

      def thermal
        if osx?
          20 + Random.rand(11)
        else
          `awk '{printf "%3.1f", $1/1000}' /sys/class/thermal/thermal_zone0/temp`.strip.to_f
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