class MutationType < Lib::Objects::Base
  field :createUser, mutation: Users::Mutations::Create

  field :createSession, mutation: Sessions::Mutations::Create

  field :createProject, mutation: Projects::Mutations::Create
  field :updateProject, mutation: Projects::Mutations::Update
  field :destroyProject, mutation: Projects::Mutations::Destroy

  field :createTask, mutation: Tasks::Mutations::Create
  field :updateTask, mutation: Tasks::Mutations::Update
  field :destroyTask, mutation: Tasks::Mutations::Destroy

  field :createComment, mutation: Comments::Mutations::Create
  field :destroyComment, mutation: Comments::Mutations::Destroy
end
