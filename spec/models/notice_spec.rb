require 'spec_helper'
 
require 'models/notice.rb'

describe 'Models::Notice' do
	before do
		@empty_notice = Models::Notice.new
		@notice = Models::Notice.new(message: 'message')
	end
	
	describe '#initialize' do
		it 'sets default values' do
			time = Time.now
			expect(Time).to receive(:now).and_return(time)
			notice = Models::Notice.new
			expect(notice.message).to eq ''
			expect(notice.time).to eq time + 1
			expect(notice.type).to eq :notice
		end
		it 'sets params values' do
			time = Time.now + 100
			notice = Models::Notice.new(message: 'message', time: time, type: :type)
			expect(notice.message).to eq 'message'
			expect(notice.time).to eq time
			expect(notice.type).to eq :type
		end
	end

	describe '#delete_on_over!' do
		it 'deletes on over' do
			expect(@notice).to receive(:is_over?).and_return(true)
			expect(@notice).to receive(:delete).and_return(true)
			expect(@notice.delete_on_over!).to be_truthy
		end
		
		it 'does nothing when valid' do
			expect(@notice).to receive(:is_over?).and_return(false)
			expect(@notice).to_not receive(:delete)
			expect(@notice.delete_on_over!).to be_falsy
		end
	end

	describe '#is_over' do
		it 'refutes' do
			notive = Models::Notice.new(time: Time.now + 1000)
			expect(notive.is_over?).to be_falsy
		end

		it 'asserts on old time' do
			notive = Models::Notice.new(time: Time.now - 1000)
			expect(notive.is_over?).to be_truthy
		end

		it 'asserts on eq time' do
			time = Time.now
			expect(Time).to receive(:now).and_return(time)
			notive = Models::Notice.new(time: time)
			expect(notive.is_over?).to be_truthy
		end
	end

	describe '#size' do
		it 'returns message size' do
			expect(@notice.size).to eq 'message'.size
			expect(@empty_notice.size).to eq 0
		end
	end
end