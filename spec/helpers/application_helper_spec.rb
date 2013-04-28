require 'spec_helper'

describe ApplicationHelper do
  describe "full_title" do
    context "Home page" do
      it "not include a bar" do
        expect(full_title('')).to_not match(/\|/)
      end
    end

    context "Other pages" do
      subject { full_title('foo') }
      it "include the base title" do
        expect(subject).to match(/^Ruby on Rails Tutorial App/)
      end

      it "include the page title" do
        expect(subject).to match(/foo/)
      end
    end
  end
end
