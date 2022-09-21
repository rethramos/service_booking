require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'foobar',
                    password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'should require first name' do
    @user.first_name = ' ' * 50
    assert_not @user.valid?
  end

  test 'first_name should be at most 50 characters' do
    @user.first_name = 'a' * 51
    assert_not @user.valid?
  end

  test 'should require timezone' do
    @user.timezone = '    '
    assert_not @user.valid?
  end

  test 'timezone should be supported' do
    @user.timezone = 'Wrong'
    assert_not @user.valid?
  end

  test 'should require email' do
    @user.email = ' ' * 255
    assert_not @user.valid?
  end

  test 'email should be at most 255 characters' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email should accept valid addresses' do
    valid_addresses = %w[user@example.com
                         USER@foo.COM
                         A_US-ER@foo.bar.org
                         first.last@foo.jp
                         alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email should reject invalid addresses' do
    invalid_addresses = %w[user@example,com
                           user_at_foo.org
                           user.name@example.
                           foo@bar_baz.com
                           foo@bar+baz.com
                           foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved in lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'should require password' do
    password = ' ' * 6
    @user.password = password
    @user.password_confirmation = password
    assert_not @user.valid?
  end
  
  test 'password should be at least 6 characters' do
    password = 'b' * 5
    @user.password = password
    @user.password_confirmation = password
    assert_not @user.valid?
  end

  test 'password confirmation should match password' do
    @user.password_confirmation = 'a password'
    assert_not @user.valid?
  end
end
