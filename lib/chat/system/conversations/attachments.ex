defmodule Chat.System.Attachments do
  import Ecto.Query, warn: false
  alias Chat.Repo
  alias System, as: SystemAlias
  alias Chat.{System.Attachment, System}

  @doc """
  Returns the list of attachments.

  ## Examples

      iex> list()
      [%Attachment{}, ...]

  """
  def list do
    Repo.all(Attachment)
  end

  @doc """
  Gets a single attachment.

  Raises `Ecto.NoResultsError` if the Attachment does not exist.

  ## Examples

      iex> get!(123)
      %Attachment{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Attachment, id)

  @doc """
  Creates a attachment in a conversation.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Attachment{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    with conversation_id <- Map.get(attrs, :conversation_id),
         {:ok, attachment_url} <- upload_file(attrs),
         attachment_params <- Map.put(attrs, :url, attachment_url) |> IO.inspect() do
      %Attachment{}
      |> Attachment.changeset(attachment_params)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a attachment.

  ## Examples

      iex> update(attachment, %{field: new_value})
      {:ok, %Attachment{}}

      iex> update(attachment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Attachment{} = attachment, attrs) do
    attachment
    |> Attachment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a attachment.

  ## Examples

      iex> delete(attachment)
      {:ok, %Attachment{}}

      iex> delete(attachment)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Attachment{} = attachment) do
    Repo.delete(attachment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking attachment changes.

  ## Examples

      iex> change(attachment)
      %Ecto.Changeset{data: %Attachment{}}

  """
  def change(%Attachment{} = attachment, attrs \\ %{}) do
    Attachment.changeset(attachment, attrs)
  end

  defp upload_file(attrs) do
    bucket_name = Application.get_env(:chat, :bucket_name)
    upload_path = Attachment.build_upload_path(attrs)
    url = build_url()

    attrs.attachment.path
    |> ExAws.S3.Upload.stream_file()
    |> ExAws.S3.upload(bucket_name, upload_path)
    |> ExAws.request!()

    {:ok, "#{url}#{upload_path}"}
  end

  defp build_url() do
    bucket_name = Application.get_env(:chat, :bucket_name)
    [host: host, port: port, region: _, scheme: scheme] = Application.get_env(:ex_aws, :s3)
    "#{scheme}#{host}:#{port}/#{bucket_name}"
  end
end
