defmodule Practice.Factors do
	
	# gets all the factors - prime or composite
	# during first call num should be equal to counter
	def fact(num, factors, counter) do
                cond do
                        counter <= 1 -> factors
                        rem(num, counter) == 0 -> fact(num, factors ++ [counter], counter-1)
                        true -> fact(num, factors, counter-1)
                end
        end

	# checks if a given number is prime
	# during first call num should be equal to counter-1 (actually does not matter)
        def isPrime(num, counter) do
                cond do 
                        counter < 2 -> true
                        rem(num, counter) == 0 -> false
                        true -> isPrime(num, counter-1)
                end
        end

	# checks the given list of factors for primes
	# addes the primes among them to primes argument
	# ln should be length of factors during first call
        def checkFactorsForPrimality(primes, factors, ln) do
                cond do 
                        ln == 0 -> primes
                        ln == 1 && isPrime(List.first(factors), List.first(factors)-1) -> primes ++ [List.first(factors)]
                        isPrime(List.first(factors), List.first(factors)-1) -> checkFactorsForPrimality(primes ++ [List.first(factors)], List.delete(factors, List.first(factors)), ln-1)
                        true -> checkFactorsForPrimality(primes, List.delete(factors, List.first(factors)), ln-1)
                end
        end
	
	# returns a list of primary factors
        def getPrimeFactors(num) do
                lst = fact(num,[],num)
                lst1 = Enum.sort(checkFactorsForPrimality([], lst, length(lst)))
        	getAllPrimes([],num, num, lst1)
	end

	
	def getAllPrimes(primes, num, rmndr, factors) do
                cond do
                        rmndr == 0 -> primes
                        length(factors) == 0 -> primes
                        # length of factors is 1 and rm = 0 .. add to primes
                        rem(rmndr, List.first(factors))== 0 -> getAllPrimes(primes ++ [List.first(factors)], num, div(rmndr,List.first(factors)), factors)
                        rem(rmndr, List.first(factors))!=0 -> getAllPrimes(primes, num, rmndr, List.delete(factors, List.first(factors)))
                        true -> primes
                end
        end


end

