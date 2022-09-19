require "test_helper"

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = businesses(:two).build_address(
      line_one: 'Blk 9 Lot 8, Some Village',
      line_two: 'Brgy. Here',
      city: 'Biñan',
      province: 'Laguna',
      country: 'Philippines',
      postal_code: 4024
    )
  end

  test "should be valid" do
    assert @address.valid?
  end

  test 'should require addressable ID' do
    @address.addressable_id = '    '
    assert_not @address.valid?
  end

  test 'should require addressable type' do
    @address.addressable_type = '    '
    assert_not @address.valid?
  end

  test 'should require line one' do
    @address.line_one = '   '
    assert_not @address.valid?
  end

  test 'line one should be at most 100 characters' do
    @address.line_one = 'a' * 101
    assert_not @address.valid?
  end

  test 'should require line two' do
    @address.line_two = '   '
    assert_not @address.valid?
  end

  test 'line two should be at most 100 characters' do
    @address.line_two = 'a' * 101
    assert_not @address.valid?
  end

  test 'should require city' do
    @address.city = '   '
    assert_not @address.valid?
  end

  test 'city should be at most 100 characters' do
    @address.city = 'a' * 101
    assert_not @address.valid?
  end

  test 'should require province' do
    @address.province = '   '
    assert_not @address.valid?
  end

  test 'province should be at most 100 characters' do
    @address.province = 'a' * 101
    assert_not @address.valid?
  end

  test 'should require country' do
    @address.country = '   '
    assert_not @address.valid?
  end

  test 'country should be at most 100 characters' do
    @address.country = 'a' * 101
    assert_not @address.valid?
  end
  
  test 'should require postal code' do
    @address.postal_code = '   '
    assert_not @address.valid?
  end

  test 'postal code should be at most 10 characters' do
    @address.postal_code = 'a' * 11
    assert_not @address.valid?
  end

  test 'postal code should be numeric' do
    @address.postal_code = '123d'
    assert_not @address.valid?
  end
end
