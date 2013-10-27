class Admin::DomainsController < AdminController

  load_and_authorize_resource

  inherit_resources

  actions :all, except: :show

  def create
    create! do |success, error|
      success.html { redirect_to [:admin, :domains] }
    end
  end

# TODO What happens, if a admin deletes his own domain?
#      Currently he would be logged out and see a 404.
=begin
  def destroy
    if params[:id] == current_mailbox.try(:domain).try(:id)
      flash[:error] = 'You can not delete the domain of your mailbox.'
      redirect_to admin_domains_path
    else
      destroy!
    end
  end
=end

  # TODO Does this work properly with inherited_resources?
  #      View uses collection method.
  def index
    @domains = Domain.managable current_mailbox
  end

  def update
    update! do |success, error|
      success.html { redirect_to [:edit, :admin, resource] }
    end
  end

end
