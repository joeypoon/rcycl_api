users = User.first_or_create(FactoryGirl.attributes_for(:user))
drivers = Driver.first_or_create(FactoryGirl.attributes_for(:driver))