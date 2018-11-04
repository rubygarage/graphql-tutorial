module Objects
  class Task < Lib::Objects::Base
    description 'A project'

    field :id, ID, null: false
    field :name, String, null: false
    field :done, Boolean, null: false
    field :position, Int, null: false
    field :created_at, Lib::Scalars::DateTime, null: false
    field :updated_at, Lib::Scalars::DateTime, null: false
    field :project, Objects::Project, null: false
    field :project_id, Int, null: false
  end
end
