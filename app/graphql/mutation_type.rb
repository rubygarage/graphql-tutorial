class MutationType < Lib::Objects::Base
  field :createUser, mutation: Users::Mutations::Create

  field :createSession, mutation: Sessions::Mutations::Create

  field :createProject, mutation: Projects::Mutations::Create
  field :updateProject, mutation: Projects::Mutations::Update
  field :destroyProject, mutation: Projects::Mutations::Destroy
end
