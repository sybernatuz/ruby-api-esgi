class UserPolicy < ApplicationPolicy

  def update?
    user.role == 'ROLE_ADMIN' or record.id == user.id
  end

  def destroy
    user.role == 'ROLE_ADMIN'
  end
end
