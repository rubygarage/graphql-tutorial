class MutationType < Lib::Objects::Base
  field :userCreate, mutation: Users::Mutations::Create

  field :sessionCreate, mutation: Sessions::Mutations::Create

  field :projectCreate, mutation: Projects::Mutations::Create
  field :projectUpdate, mutation: Projects::Mutations::Update
  field :projectDestroy, mutation: Projects::Mutations::Destroy

  field :taskCreate, mutation: Tasks::Mutations::Create
  field :taskUpdate, mutation: Tasks::Mutations::Update
  field :taskDestroy, mutation: Tasks::Mutations::Destroy

  field :commentCreate, mutation: Comments::Mutations::Create
  field :commentDestroy, mutation: Comments::Mutations::Destroy
end
