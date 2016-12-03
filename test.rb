require 'test/unit'
require_relative 'prepend_and_append'

class PrependAndAppendTest < Test::Unit::TestCase
  test 'exists module' do
    assert defined?(PrependAndAppend)
  end

  test 'calls block after method scope' do
    class Human
      include PrependAndAppend
      def say() 'hello!'; end
    end

    human = Human.new
    human.append('say') { 'hi!' }

    assert_equal 'hi!', human.say
  end

  test 'calls block before method scope' do
    class Human
      include PrependAndAppend
      def say() 'hello!'; end
    end

    human = Human.new
    human.append('say') { 'hi!' }

    assert_equal 'hi!', human.say
  end
end
