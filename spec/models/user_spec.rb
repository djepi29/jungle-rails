require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.new(
      email: 'test@example.com',
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is invalid when password and password_confirmation do not match' do
      user.password_confirmation = 'different_password'
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with a non-unique email (case-insensitive)' do
      user.save

      duplicate_user = described_class.new(
        email: 'TEST@example.com',
        first_name: 'Jane',
        last_name: 'Smith',
        password: 'password456',
        password_confirmation: 'password456'
      )

      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email]).to include('has already been taken')
    end

    it 'is invalid without a first name' do
      user.first_name = nil
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'is invalid without a last name' do
      user.last_name = nil
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid with a short password' do
      user.password = 'short'
      user.password_confirmation = 'short'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = described_class.create(
        email: 'example@domain.com',
        password: 'password123',
        first_name: 'John',
        last_name: 'Doe'
      )
    end

    it 'returns the user when authenticated with correct email and password' do
      authenticated_user = User.authenticate_with_credentials('example@domain.com', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns nil when authenticated with incorrect password' do
      authenticated_user = User.authenticate_with_credentials('example@domain.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil when authenticated with incorrect email' do
      authenticated_user = User.authenticate_with_credentials('wrong_email@example.com', 'password123')
      expect(authenticated_user).to be_nil
    end

    it 'returns the user when authenticated with correct email (with leading/trailing whitespace) and password' do
      authenticated_user = User.authenticate_with_credentials('  example@domain.com  ', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns the user when authenticated with correct email (case-insensitive) and password' do
      authenticated_user = User.authenticate_with_credentials('eXample@domain.COM', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns the user when authenticated with email (case-insensitive) and password with leading/trailing whitespace' do
      authenticated_user = User.authenticate_with_credentials('  eXample@domain.COM  ', 'password123')
      expect(authenticated_user).to eq(@user)
    end
  end
end