require("spec_helper")


describe(Train) do
  describe('#initialize') do
    it "check initial parameters" do
      test_train = Train.new({:route => "green"})
      expect(test_train.route()).to(eq("green"))
    end
  end
  describe('#save') do
    it "save it to database" do
      test_train = Train.new({:route => "green"})
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end
  describe('.all') do
    it "select all trains from database" do
      test_train1 = Train.new({:route => "green"})
      test_train1.save()
      test_train2 = Train.new({:route => "blue"})
      test_train2.save()
      expect(Train.all()).to(eq([test_train1, test_train2]))
    end
  end

  describe('#==') do
    it "overides equals" do
      test_train1 = Train.new({:route => "green"})
      test_train2 = Train.new({:route => "green"})
      expect(test_train1).to(eq(test_train2))
    end
  end

  describe("#delete") do
    it "deletes train from database" do
      test_train2 = Train.new({:route => "blue"})
      test_train2.save()
      test_train2.delete()
      expect(Train.all()).to(eq([]))
    end
  end

  describe("#update") do
    it "lets you update train in the database" do
      test_train = Train.new({:route => "blue"})
      test_train.save()
      test_train.update({:route => "green"})
      expect(test_train.route).to(eq("green"))
    end
  end





end
