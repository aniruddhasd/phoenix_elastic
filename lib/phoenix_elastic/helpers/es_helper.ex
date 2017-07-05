defmodule PhoenixElastic.ESHelper do
	
	import Tirexs.HTTP

	def add_document(store) do
		url = "/my_playground/store/" <> to_string(store.id)
		encoded = Poison.encode!(store)
		put(url,encoded)
	end

end