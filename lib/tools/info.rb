module Tools
  class Info
    class << self
      def ip
        if osx?
          `ifconfig en1 | grep inet | grep -v inet6 | cut -c 7-17`.strip
        else
          `hostname`.strip
        end
      end

      def thermal
        if osx?
          '?'
        else
          `awk '{printf "%3.1f\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp`.strip
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