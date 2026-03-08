Category.where("name LIKE ?", "%、").destroy_all
%i[仕事 プライベート 勉強 その他].each do |name|
    Category.find_or_create_by!(name: name)
end
