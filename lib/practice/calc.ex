defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    #expr
    #|> String.split(~r/\s+/)
    #|> hd
    #|> parse_float
    #|> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching

     {num, _} = Integer.parse(List.first(precedenceEval(String.split(expr, " "))))
     num
  end

	def findInstance(lst, op) do
                if Enum.member?(lst,op) do
                        getIndex(0, lst, op)
                else
                        -1
                end
        end

        def getIndex(index, lst, op) do
                cond do 
                        length(lst) == 0 -> -1
                        List.first(lst) == op -> index
                        true -> getIndex(index+1, List.delete(lst, List.first(lst)), op)
                end
        end

        def getExpr(lst, index) do
                left_index = index-1
                right_index = index+2
                Enum.slice(lst, left_index..right_index)
        end

        def evaluateOperator(lst, op, index) do
                if index == -1 do
                        lst
                else
                        ans = evalExpression(getExpr(lst, index))
                        getNewExpression(lst, index, ans)
                end
        end

        def precedenceEval(lst) do
                cond do
                        length(lst) == 1 -> lst
                        Enum.member?(lst,"/") -> precedenceEval(evaluateOperator(lst, "/", findInstance(lst, "/")))
                        Enum.member?(lst,"*") -> precedenceEval(evaluateOperator(lst, "*", findInstance(lst, "*")))
                        Enum.member?(lst,"+") -> precedenceEval(evaluateOperator(lst, "+", findInstance(lst, "+")))
                        Enum.member?(lst,"-") -> precedenceEval(evaluateOperator(lst, "-", findInstance(lst, "-")))
                        true -> lst
                end
        end

	
	def evalExpression(lst) do
                num1 = parse_float(Enum.at(lst,0))
                num2 = parse_float(Enum.at(lst,2))
                op = Enum.at(lst,1)
                cond do
                        op == "/" -> Float.to_string(num1/num2)
                        op == "*" -> Float.to_string(num1*num2)
                        op == "+" -> Float.to_string(num1+num2)
                        op == "-" -> Float.to_string(num1-num2)
                        true -> "1.0"
                end
        end

        def getNewExpression(origLst, index, answer) do
                cond do
                        index == 1 -> [answer] ++ Enum.slice(origLst, index+2..length(origLst))
                        true -> Enum.slice(origLst, 0..index-2) ++ [answer] ++ Enum.slice(origLst, index+2..length(origLst))
                end
        end

end
