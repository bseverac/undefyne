require 'spec_helper'
 
require 'models/command.rb'

describe 'Models::Command' do
	before do
		@command_without_brackets = Models::Command.new(string: 'without')
		@command_with_brackets = Models::Command.new(string: 'with()')
		@command_with_param = Models::Command.new(string: 'with_param(toto)')
		@command_with_params = Models::Command.new(string: 'with_params(toto, tata)')

		@bad_syntax_commands = [Models::Command.new(string: 'with(toto')]
		@bad_syntax_commands << Models::Command.new(string: 'with toto')
		@bad_syntax_commands << Models::Command.new(string: 'with(')
		@bad_syntax_commands << Models::Command.new(string: 'with)')
		@bad_syntax_commands << Models::Command.new(string: 'with sdf')
		@bad_syntax_commands << Models::Command.new(string: 'with(d)(d)')
	end
	
	describe '#method' do
		it 'returns command' do
			expect(@command_without_brackets.method).to eq 'without'
			expect(@command_with_brackets.method).to eq 'with'
			expect(@command_with_param.method).to eq 'with_param'
			expect(@command_with_params.method).to eq 'with_params'
		end

		it 'returns nil on bad syntax' do
			@bad_syntax_commands.each do |command|
				expect(command.method).to be_nil
			end
		end
	end

	describe '#params?' do
		it 'refutes' do
			expect(@command_without_brackets.params?).to be_falsy
			expect(@command_with_brackets.params?).to be_falsy
			@bad_syntax_commands.each do |command|
				expect(command.params?).to be_falsy
			end
		end

		it 'asserts' do
			expect(@command_with_param.params?).to be_truthy
			expect(@command_with_params.params?).to be_truthy
		end
	end

	describe '#params' do
		it 'returns empty array' do
			expect(@command_without_brackets.params).to eq []
			expect(@command_with_brackets.params).to eq []
			@bad_syntax_commands.each do |command|
				expect(command.params).to eq []
			end
		end

		it 'returns array of param' do
			expect(@command_with_param.params).to eq ['toto']
			expect(@command_with_params.params).to eq ['toto', 'tata']
		end
	end
end