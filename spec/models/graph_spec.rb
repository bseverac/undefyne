require 'spec_helper'
 
require 'models/graph.rb'

describe 'Models::Graph' do
	before do
		values = [3, 14, 5, 4.5, 2.1, 5]
		@graph = Models::Graph.new(values: values)
		values_1 = [50, 50, 50, 100, 100, 100]
		@graph_1 = Models::Graph.new(values: values_1)
		values_2 = [102, 202]
		@graph_2 = Models::Graph.new(values: values_2)
		values_3 = [203, 203, 203, 203, 203, 203, 303, 303, 303, 303, 303, 303]
		@graph_3 = Models::Graph.new(values: values_3)
	end

	describe '#max_size_ordinate_value' do
		it 'gets max ordinate size for max value' do
			expect(@graph).to receive(:min_ordinate_string).and_return('1')
			expect(@graph).to receive(:max_ordinate_string).and_return('22')
			width = @graph.send :max_size_ordinate_value
			expect(width).to eq 2
		end

		it 'gets max ordinate size width for min value' do
			expect(@graph).to receive(:min_ordinate_string).and_return('4444')
			expect(@graph).to receive(:max_ordinate_string).and_return('1')
			width = @graph.send :max_size_ordinate_value
			expect(width).to eq 4
		end
	end
	
	describe '#min_ordinate_string' do
		it 'returns min ordinate string' do
			width = @graph.send :min_ordinate_string
			expect(width).to eq '2.1'
		end
	end

	describe '#max_ordinate_string' do
		it 'returns min ordinate string' do
			width = @graph.send :max_ordinate_string
			expect(width).to eq '14'
		end
	end

	describe '#ordinate_width' do
		it 'adds 1 to max_size' do
			expect(@graph).to receive(:max_size_ordinate_value).and_return(1)
			width = @graph.send :ordinate_width
			expect(width).to eq 2
		end
	end

	describe '#get_ordinate_string' do
		it 'returns ordinate string on max threshold' do
			string = @graph.send(:get_ordinate_string, 0)
			expect(string).to eq "14 │"
		end

		it 'returns ordinate string on middle' do
			string = @graph.send(:get_ordinate_string, 5)
			expect(string).to eq "   │"
		end

		it 'returns ordinate string on min threshold' do
			string = @graph.send(:get_ordinate_string, 9)
			expect(string).to eq "2.1│"
		end
	end

	describe '#get_row' do
		it 'returns last row' do
			row1 = @graph_1.send(:get_row, 9)
			row2 = @graph_2.send(:get_row, 9)
			row3 = @graph_3.send(:get_row, 9)
			expect(row1.to_s).to eq '50 │██████'
			expect(row2.to_s).to eq '102│██████'
			expect(row3.to_s).to eq '203│██████'
		end
		it 'returns first row' do
			row1 = @graph_1.send(:get_row, 0)
			row2 = @graph_2.send(:get_row, 0)
			row3 = @graph_3.send(:get_row, 0)
			expect(row1.to_s).to eq '100│   ███'
			expect(row2.to_s).to eq '202│   ███'
			expect(row3.to_s).to eq '303│   ███'
		end
	end

end