require 'test/unit'
require_relative 'lib/prepend_and_append'

class PrependAndAppendTest < Test::Unit::TestCase

  def setup
    if defined? PrependAndAppendTest::Human
      return
    end

    self.class.const_set :Human, Class.new {
      include PrependAndAppend
      def say() 'hello!'; end
    }
  end

  test 'exists module' do
    assert defined?(PrependAndAppend)
  end

  test 'calls block after method scope' do
    human = Human.new
    human.append('say') { 'hi!' }

    assert_equal 'hi!', human.say
  end

  test 'calls block before method scope' do
    human = Human.new
    human.prepend('say') { nil }

    assert_equal nil, human.say
  end
end
