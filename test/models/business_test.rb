require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
  def setup
    @business = users(:john).businesses.build(
      name: 'Barber Shop'
    )
  end

  test 'should be valid' do
    assert @business.valid?
  end

  test 'should require user' do
    @business.user = nil
    assert_not @business.valid?
  end

  test 'should require name' do
    @business.name = '    '
    assert_not @business.valid?
  end

  test 'name should be at most 100 characters' do
    @business.name = 'a' * 101
    assert_not @business.valid?
  end
  
  test 'should require timezone' do
    @business.timezone = '    '
    assert_not @business.valid?
  end

  test 'timezone should be supported' do
    @business.timezone = 'Wrong'
    assert_not @business.valid?
  end
end
