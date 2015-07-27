require 'spec_helper'
 
require 'models/base.rb'

describe 'Models::Base' do
	describe 'class method' do
		describe '#all' do
			context 'with empty collection' do
				it 'return empty array' do
					expect(Models::Base.all).to eq []
				end
			end

			context 'with collection' do
				it 'return collection' do
					5.times{ Models::Base.create() }
					expect(Models::Base.all.count).to eq 5
				end
			end
		end

		describe '#create' do
			context 'with no param' do
				it 'return new object' do
					expect(Models::Base.create).to be_a Models::Base
				end
			end

			context 'with hash param' do
				it 'return new object' do
					expect(Models::Base.create(foo: :bar)).to be_a Models::Base
				end
			end

			context 'without hash param' do
				it 'return new object' do
					expect { Models::Base.create('bad parameter') }.to raise_error("Params must be a hash, actual: 'String'")
				end
			end
		end

		describe '#delete' do
			context 'with a collection' do
				before do
					@object = Models::Base.create
				end

				context 'detroy unexistant object' do
					it 'refute' do
						expect(Models::Base.delete('toto')).to be_falsy
					end
				end

				context 'detroy unexistant object' do
					it 'assert and remove object from collection' do
						initial_count = Models::Base.all.size
						expect(Models::Base.delete(@object)).to be_truthy
						expect(Models::Base.all.size).to eq initial_count - 1
					end
				end
			end
		end

		describe '#find_by_index' do
			before do
				Models::Base.clear
				@object_0 = Models::Base.create
				@object_1 = Models::Base.create
			end
			context 'out of range' do
				it 'return nil' do
					expect(Models::Base.find_by_index(2)).to be_nil
				end
			end

			context 'in range' do
				it 'return object' do
					expect(Models::Base.find_by_index(0)).to eq @object_0
					expect(Models::Base.find_by_index(1)).to eq @object_1
					expect(Models::Base.find_by_index(-1)).to eq @object_1
				end
			end
		end

		describe '#clear' do
			context 'with a collection' do
				before do
					Models::Base.clear
					5.times{ Models::Base.create }
				end

				it 'clear all collection' do
					expect(Models::Base.all.count).to eq 5
					expect(Models::Base.clear).to be_truthy
					expect(Models::Base.all.count).to eq 0
				end
			end
		end
	end
	describe 'instance method' do
		describe '#delete' do
			it 'removes from collection' do
				object = Models::Base.new
				expect(Models::Base).to receive(:delete).with(object).and_return(true)
				expect(object.delete).to be_truthy
			end
		end
	end
end