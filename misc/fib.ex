defmodule Fib do
	@moduledoc """
	Memoized recursive fibbonacci implementation.

	The right part of the fibbonacci calculation is memoized: the left
	part is not. This should be analagous to a fully memoized implementation
	(where both left and right are memoized). The computation complexity here
	should be O(n).
	
	Not really suitable outside of a test environment. A somewhat
	better implementation will implement either a generator pattern or allow
	for list comprehension.
	"""
	def fib(x) do
		{r , m} = fibm(x)
		r
	end

	defp fibm(x) do
		fibm(x, %{})
	end

	defp fibm(x, mem) when x <= 2 do
		{x, %{x => x}}
	end

	defp fibm(x, mem) do
		if Map.has_key?(mem,x) do
			{Map.get(mem,x), mem}
		else
    		{left, left_map} = fibm(x-1, mem)
			mem = Map.merge(left_map, mem)
			{right, right_map} = fibm(x-2, mem)
			mem = Map.merge(right_map, mem)
			result = left+right
			mem = Map.put(mem, x, result)
			{result, mem}
		end
	end
end