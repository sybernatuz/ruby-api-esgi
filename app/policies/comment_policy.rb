class CommentPolicy < ApplicationPolicy

  def update?
    user.role == 'ROLE_ADMIN' or record.user.id == user.id
  end

  def destroy?
    user.role == 'ROLE_ADMIN' or record.user.id == user.id
  end
end
