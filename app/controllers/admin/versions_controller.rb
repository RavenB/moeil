# Versions controller.
class Admin::VersionsController < AdminController

  load_and_authorize_resource

  inherit_resources

  # Paginated index, newest change first.
  def index
    @versions = Version.order('created_at desc').page(params[:page]).per(10)
  end

  # Revert a version.
  def revert
    @version = Version.find(params[:id])

    if ['update', 'destroy'].include? @version.event
      @version.reify.save!
      redirect_to [:admin, :versions], notice: "Reverted #{@version.event}."
    else
      redirect_to [:admin, :versions], flash: { error: "Impossible to revert #{@version.event}." }
    end
  end

end
