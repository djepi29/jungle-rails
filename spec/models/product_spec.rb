require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # Create a category for the examples
    before(:each) do
      @category = Category.create(name: 'Electronics')
    end

    # Product with all fields set should save successfully
    it 'saves successfully when all fields are set' do
      product = Product.new(
        name: 'Test Product',
        price: 9.99,
        quantity: 10,
        category: @category
      )
      expect(product).to be_valid
    end

    # Validation of presence for :name
    it 'validates presence of name' do
      product = Product.new(
        price: 9.99,
        quantity: 10,
        category: @category
      )
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    # Validation of presence for :price
    it 'validates presence of price' do
      product = Product.new(
        name: 'Test Product',
        quantity: 10,
        category: @category
      )
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    # Validation of presence for :quantity
    it 'validates presence of quantity' do
      product = Product.new(
        name: 'Test Product',
        price: 9.99,
        category: @category
      )
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    # Validation of presence for :category
    it 'validates presence of category' do
      product = Product.new(
        name: 'Test Product',
        price: 9.99,
        quantity: 10
      )
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
