class MutationType < Lib::Objects::Base
  field :createUser, mutation: Users::Mutations::Create

  field :createSession, mutation: Sessions::Mutations::Create
end
