require 'spec_helper'
 
require 'models/input.rb'

describe 'Models::Input' do
	before do
		@empty_input = Models::Input.new
		@input = Models::Input.new(string: 'not_empty')
	end
	
	describe '#add' do
		it 'adds character' do
			@empty_input.add('i')
			expect(@empty_input.string).to eq 'i'
			@empty_input.add('i')
			expect(@empty_input.string).to eq 'ii'
		end
	end

	describe '#chomp' do
		it 'removes last character' do
			@empty_input.chomp
			@input.chomp
			expect(@empty_input.string).to eq ''
			expect(@input.string).to eq 'not_empt'
		end
	end

	describe '#clear' do
		it 'clears string' do
			@empty_input.clear
			@input.clear
			expect(@empty_input.string).to eq ''
			expect(@input.string).to eq ''
		end
	end	

	describe '#empty?' do
		it 'refutes' do
			expect(@empty_input.empty?).to be_truthy
		end

		it 'asserts' do
			expect(@input.empty?).to be_falsy
		end
	end

	describe '#set' do
		it 'replace string' do
			@input.set 'new_string'
			expect(@input.string).to eq 'new_string'
		end
	end
end