# Hexa
A simple module for Hexadecimal encoding / decoding in Elixir

### Usage

Encode to binary:
```elixir
iex> Hexa.encode("This is a test.")
     "54686973206973206120746573742e"

iex> Hexa.encode('This is a test.')
     "54686973206973206120746573742e"

iex> Hexa.encode(123456)
     "1e240"
```

Decode to binary:
```elixir
iex> Hexa.decode("54686973206973206120746573742e")
     "This is a test."

iex> Hexa.decode('54686973206973206120746573742e')
     "This is a test."
```

Encode to list:
```elixir
iex> Hexa.encode_to_list('This is a test.')
     '54686973206973206120746573742e'

iex> Hexa.encode_to_list("This is a test.")
     '54686973206973206120746573742e'

iex> Hexa.encode(123456)
     '1e240'
```

Decode to list:
```elixir
iex> Hexa.decode('54686973206973206120746573742e')
     'This is a test.'

iex> Hexa.decode("54686973206973206120746573742e")
     'This is a test.'
```

Convert hex to integer:
```elixir
iex> Hexa.to_integer('54686973206973206120746573742e')
     438270661302729020147902120434299950

iex> Hexa.to_integer("54686973206973206120746573742e")
     438270661302729020147902120434299950
```
