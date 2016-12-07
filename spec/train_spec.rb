require("spec_helper")


describe(Train) do
  describe('#initialize') do
    it "check initial parameters" do
      test_train = Train.new({:route => "green"})
      expect(test_train.route()).to(eq("green"))
    end
  end
end
