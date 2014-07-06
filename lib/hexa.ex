defmodule Hexa do
  @moduledoc """
  A simple module to convert to and from hex encoded strings.

  Encodes / decodes both lists and binaries.
  """

  @doc """
  Returns a hex encoded binary from a list, binary or integer.

  ## Examples

      iex> Hexa.encode("This is a test.")
      "54686973206973206120746573742e"

      iex> Hexa.encode('This is a test.')
      "54686973206973206120746573742e"

      iex> Hexa.encode(123456)
      "1e240"
  """
  def encode(str) when is_binary(str) do
    binary_to_hex_list(str)
    |> :erlang.iolist_to_binary
  end

  def encode(str) when is_list(str) do
    list_to_hex(str)
    |> :erlang.iolist_to_binary
  end

  def encode(int) when is_integer(int) do
    :erlang.integer_to_binary(int, 16)
    |> String.downcase
  end

  @doc """
  Returns a hex encoded list from a list, binary or integer.

  ## Examples

      iex> Hexa.encode_to_list("This is a test.")
      '54686973206973206120746573742e'

      iex> Hexa.encode_to_list('This is a test.')
      '54686973206973206120746573742e'

      iex> Hexa.encode_to_list(123456)
      '1e240'
  """
  def encode_to_list(str) when is_binary(str) do
    binary_to_hex_list(str)
  end

  def encode_to_list(str) when is_list(str) do
    list_to_hex(str)
  end

  def encode_to_list(int) when is_integer(int) do
    :erlang.integer_to_list(int, 16)
    |> :string.to_lower
  end

  @doc """
  Returns a decoded binary from a hex string in either list
  or binary form.

  ## Examples

      iex> Hexa.decode("54686973206973206120746573742e")
      "This is a test."

      iex> Hexa.decode('54686973206973206120746573742e')
      "This is a test."
  """
  def decode(hex_str) when is_binary(hex_str) do
    :binary.bin_to_list(hex_str)
    |> hex_str_to_list
    |> :erlang.iolist_to_binary
  end

  def decode(hex_str) when is_list(hex_str) do
    hex_str_to_list(hex_str)
    |> :erlang.iolist_to_binary
  end

  @doc """
  Returns a decoded list from a hex string in either list
  or binary form.

  ## Examples

      iex> Hexa.decode_to_list("54686973206973206120746573742e")
      'This is a test.'

      iex> Hexa.decode_to_list('54686973206973206120746573742e')
      'This is a test.'
  """
  def decode_to_list(hex_str) when is_binary(hex_str) do
    :binary.bin_to_list(hex_str)
    |> hex_str_to_list
  end

  def decode_to_list(hex_str) when is_list(hex_str) do
    hex_str_to_list(hex_str)
  end

  @doc """
  Returns an integer representation of a given string of hex,
  taking a list or a binary as an argument.

  ## Examples

      iex> Hexa.to_integer('54686973206973206120746573742e')
      438270661302729020147902120434299950

      iex> Hexa.to_integer("54686973206973206120746573742e")
      438270661302729020147902120434299950
  """
  def to_integer(hex_str) when is_list(hex_str) do
    List.to_integer(hex_str, 16)
  end

  def to_integer(hex_str) when is_binary(hex_str) do
    String.to_integer(hex_str, 16)
  end

  defp binary_to_hex_list(str) do
    :binary.bin_to_list(str)
    |> list_to_hex
  end

  defp hex_str_to_list([]) do
    []
  end

  defp hex_str_to_list([x,y|tail]) do
    [to_int(x) * 16 + to_int(y) | hex_str_to_list(tail)]
  end

  defp list_to_hex([]) do
    []
  end

  defp list_to_hex([head|tail]) do
    to_hex_str(head) ++ list_to_hex(tail)
  end

  defp to_hex_str(n) when n < 256 do
    [to_hex(div(n, 16)), to_hex(rem(n, 16))]
  end

  defp to_hex(i) when i < 10 do
    0 + i + 48
  end

  defp to_hex(i) when i >= 10 and i < 16 do
    ?a + (i - 10)
  end

  defp to_int(c) when ?0 <= c and c <= ?9 do
    c - ?0
  end

  defp to_int(c) when ?A <= c and c <= ?F do
    c - ?A + 10
  end

  defp to_int(c) when ?a <= c and c <= ?f do
    c - ?a + 10
  end
end
