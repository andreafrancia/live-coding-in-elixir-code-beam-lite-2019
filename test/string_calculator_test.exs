defmodule StringCalculatorTestMacro do
  defmacro test_sum_of(text, is: expected_value) do
    message = text
    ast = quote do
      test unquote(message) do
        assert unquote(expected_value) == sum_of(unquote(text))
      end
    end
    ast
  end
end
defmodule StringCalculatorTest do
  use ExUnit.Case
  import StringCalculator
  import StringCalculatorTestMacro

  test "how to define a macro" do
    ast = quote do 
      test_sum_of("1", is: 1)
    end
    ast = Macro.expand_once(ast, __ENV__)
    assert "test(\"1\") do\n  assert(1 == sum_of(\"1\"))\nend" == 
      Macro.to_string(ast)
  end

  describe "sum of an empty string is 0" do
    test_sum_of("", is: 0)
  end
  describe "the sum of a string with one number is the number" do
    test_sum_of("1", is: 1)
    test_sum_of("2", is: 2)
  end
  describe "the sum of a string with comma separated values is the sum of .." do
    test_sum_of("1,2", is: 3)
    test_sum_of("1,2,3", is: 6)
  end
  describe "it works also with new lines as separator" do
    test_sum_of("1\n3", is: 4)
  end
  describe "custom separator" do
    test_sum_of("//_\n1_2", is: 3)
    test_sum_of("//?\n4?2", is: 6)
  end
end
