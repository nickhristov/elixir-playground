defmodule FibServer do

	def client_next(pid) do
		send pid, {:next, self()}
		receive do
			{:ok, next} -> next
		end
	end

	def serve() do
		next(0,1)
		next(1,1)
		loop(&FibServer.next/2, 1, 2)
	end

	def loop(func, first, second) do 
		next = func.(first,second)
		loop(func, second, next)
	end

	def next(first, second) do
		next = first+second
		receive do
			{:next, caller} -> send caller, {:ok, next}
		end
		next
	end
end