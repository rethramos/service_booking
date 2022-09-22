require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase
  def setup
    @receipt = users(:john).receipts.build(
      payment_option: PaymentOption.find_by(name: PaymentOption::PAYPAL),
      first_name: users(:john).first_name,
      last_name: users(:john).last_name,
      email: users(:john).email,
      contact_number: '+639123456722'
    )
    @receipt.build_address(
      line_one: 'Something',
      line_two: 'somthing',
      city: 'Sity',
      province: 'province',
      country: 'Philippines',
      postal_code: 4024
    )
  end

  test 'should be valid' do
    assert @receipt.valid?
  end

  test 'should require payment option' do
    @receipt.payment_option = nil
    assert_not @receipt.valid?
  end

  test 'should require address' do
    @receipt.address = nil
    assert_not @receipt.valid?
  end

  test 'address should be valid' do
    @receipt.address.country = '    '
    assert_not @receipt.valid?
  end

  test 'should require first name' do
    @receipt.first_name = '    '
    assert_not @receipt.valid?
  end

  test 'first name should be at most 50 characters' do
    @receipt.first_name = 'a' * 51
    assert_not @receipt.valid?
  end

  test 'should require last name' do
    @receipt.last_name = '    '
    assert_not @receipt.valid?
  end

  test 'last name should be at most 50 characters' do
    @receipt.last_name = 'a' * 51
    assert_not @receipt.valid?
  end

  test 'should require email' do
    @receipt.email = '    '
    assert_not @receipt.valid?
  end

  test 'email addresses should be saved in lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @receipt.email = mixed_case_email
    @receipt.save
    assert_equal mixed_case_email.downcase, @receipt.reload.email
  end

  test 'should require contact number' do
    @receipt.contact_number = '    '
    assert_not @receipt.valid?
  end
end
