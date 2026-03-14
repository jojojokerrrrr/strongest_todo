require "rails_helper"

RSpec.describe Task, type: :model do
  describe "validations" do
    let(:task) { build(:task) }

    context "全て有効な場合" do
      it "保存に成功すること" do
        expect(task).to be_valid
      end
    end

    context "titleが50文字を超える場合" do
      let(:task) { build(:task, title: "a" * 51) }
      it "保存できないこと" do
        expect(task).to be_invalid
      end
    end

    context "descriptionが500文字を超える場合" do
      let(:task) { build(:task, description: "a" * 501) }
      it "保存できないこと" do
        expect(task).to be_invalid
      end
    end

    context "titleがない場合" do
      let(:task) { build(:task, title: "") }
      it "保存できないこと" do
        expect(task).to be_invalid
      end
    end

    context "カテゴリーがない場合" do
      let(:task) { build(:task, category: nil) }
      it "保存できないこと" do
        expect(task).to be_invalid
      end
    end
  end

  describe "enum" do
    let(:task) { build(:task) }

    context "statusのデフォルト" do
      it "incompleteであること" do
        expect(task.status).to eq ("incomplete")
      end
    end
  end
end
