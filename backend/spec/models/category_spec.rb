require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validation" do
    let(:category) {build(:category)}
    context "nameが入力されている場合" do
      it "保存できること" do
        expect(category).to be_valid
      end
    end

    context "nameが入力されていない場合" do
      let(:invalid_category) {build(:category, name: "")}
      it "保存できないこと" do
        expect(invalid_category).not_to be_valid
      end
    end
  end
end
