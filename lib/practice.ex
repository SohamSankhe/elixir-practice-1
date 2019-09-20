defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Maybe delegate this too.
    #[1,2,x]
    Practice.Factors.getPrimeFactors(getInt(x))
  end

  # TODO: Add a palindrome? function.
  def palindrome?(x) do
    x == String.reverse(x)
  end

  def getFactors(num, factors, counter) do
     cond do
        counter <= 2 -> factors
        rem(num, counter) == 0 -> getFactors(num, factors ++ [counter], counter-1)
        true -> getFactors(num, factors, counter-1)
     end
  end
  
  def getInt(text) do
     if is_integer(text) do
	text
     else
	{num, _} = Integer.parse(text)
     	num
     end
  end

end
