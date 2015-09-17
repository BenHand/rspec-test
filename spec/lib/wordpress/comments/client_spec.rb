# coding utf-8
require_relative '../../../../lib/wordpress/comments/client'
require_relative '../../../support/match_date'

describe Wordpress::Comments::Client do

  let(:client) { Wordpress::Comments::Client.new('http://mashable.com/comments/feed') }

  describe "#initialize" do
    it "stores a url" do
      expect(client.url).to eq 'http://mashable.com/comments/feed'
    end
  end

  describe '#parse' do
    let(:xml)      { File.read(File.join('spec', 'fixtures', 'feed.xml')) }
    let(:comments) { client.parse xml }
    let(:comment)  { comments.first }

    it 'extracts the link' do
      link     = "http://mashable.com/2012/07/18/ipad-early-photos/comment-page-1/#comment-18239503"
      expect(comment[:link]).to eq link
    end

    it 'extracts the title' do
      title = "Comment on The Earliest Photos of Apple’s iPad Hit the Web by Fido"
      expect(comment[:title]).to eq title
    end

    it 'extracts the name of the commenter' do
      expect(comment[:commenter]).to eq 'Fido'
    end

    it 'extracts the date' do
      # Wed, 18 Jul 2012 22:55:57 +0000
      expect(comment[:date].year).to eq 2012
    end

    it 'extracts the date (redux)' do
      expect(comment[:date]).to match_date '2012-07-18'
    end
  end

end
