module Models
	class Base
		attr_reader :string

		def initialize(params = {})
			raise "Params must be a hash, actual: '#{params.class}'" unless params.is_a?(Hash)
		end
		
		def delete
      		self.class.delete(self)
    	end

		class << self
			def all
				collection
			end
			
			def create(params = {})
				collection << object = new(params)
				object
			end
			
			def delete(model)
				collection.delete(model)
			end
			
			def find_by_index(index)
        		collection[index]
      		end

      		def clear
      			@collection = nil
      			true
      		end

			private 

			def collection
				@collection ||= []
			end
		end
	end
end