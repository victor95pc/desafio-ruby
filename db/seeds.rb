user = User.new(email: 'admin@admin.com', password: '12345678', password_confirmation: '12345678', profile: :admin)
user.skip_confirmation!
user.skip_confirmation_notification!
user.save!
