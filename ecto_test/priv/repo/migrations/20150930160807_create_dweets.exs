defmodule EctoTest.Repo.Migrations.CreateDweets do
  use Ecto.Migration

  def up do
    create table(:dweets) do
      add :content, :string, size: 140
      add :author,  :string, size: 50
    end
  end

  def down do
    drop table(:dweets)
  end
end
