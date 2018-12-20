defmodule AoC.Day8.Solution do
  def run() do
    AoC.Reader.as_string("data/8/input")
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> part_1()
    |> AoC.Writer.print(8, 1)

    AoC.Reader.as_string("data/8/input")
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> part_2()
    |> AoC.Writer.print(8, 2)
  end

  def part_1(encoded) do
    {:ok, collected} = collect_metadata(1, encoded, [])

    collected |> Enum.sum()
  end

  def part_2(encoded) do
    {tree, []} =
      encoded
      |> build_tree()

    compute_value_of_node(tree)
  end

  defp collect_metadata(0, [], collected), do: {:ok, collected}

  defp collect_metadata(0, encoded, collected), do: {collected, encoded}

  defp collect_metadata(siblings, [children, metadata_blocks | encoded], collected) do
    {new_collected, new_encoded} = collect_metadata(children, encoded, collected)

    {metadata, rest_of_encoded} = Enum.split(new_encoded, metadata_blocks)

    collect_metadata(siblings - 1, rest_of_encoded, metadata ++ new_collected)
  end

  defp build_tree([0, metadata_blocks | encoded]) do
    {metadata, new_encoded} = Enum.split(encoded, metadata_blocks)

    leaf = %{type: :leaf, children: nil, metadata: metadata}

    {leaf, new_encoded}
  end

  defp build_tree([children_count, metadata_blocks | encoded]) do
    {children, new_encoded} =
      1..children_count
      |> Enum.reduce({%{}, encoded}, fn child_id, {children, encoded} ->
        {sub_tree, new_encoded} = build_tree(encoded)

        new_children = Map.put_new(children, child_id, sub_tree)

        {new_children, new_encoded}
      end)

    {metadata, rest_of_encoded} = Enum.split(new_encoded, metadata_blocks)

    node = %{type: :node, children: children, metadata: metadata}

    {node, rest_of_encoded}
  end

  defp compute_value_of_node(%{type: :leaf, metadata: metadata}), do: Enum.sum(metadata)

  defp compute_value_of_node(%{type: :node, children: children, metadata: indices}) do
    indices
    |> Enum.map(&Map.get(children, &1, nil))
    |> Enum.reject(&(&1 === nil))
    |> Enum.map(&compute_value_of_node/1)
    |> Enum.sum()
  end
end
