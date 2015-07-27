require 'models/base.rb'
module Models
	class Input < Base
		attr_reader :string

		def initialize(params = {})
			@string = params[:string] || ''
		end
		
		def add c
			@string += c
		end
		
		def chomp
			@string = @string[0...-1]
		end

		def clear
			@string = ''
		end

		def empty?
			@string.empty?
		end

		def set string
			@string = string
		end
	end
end