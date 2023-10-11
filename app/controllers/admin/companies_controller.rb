class Admin::CompaniesController < Admin::ApplicationController
  helper Admin::Companies::FiltersHelper
  helper Admin::ValidatorsHelper

  before_action :set_paper_trail_whodunnit

  FILTER_SCOPE = "filter".freeze

  FILTER_ASSOCIATIONS = [Practice, AssetClass, JobFunction, Location].freeze

  PARAMS_IN_COMPANIES_FILTER = %i[from till no_logo practice_ids asset_class_ids asset_class_ids location_ids undersized_logos].freeze

  def index
    @params = params.permit(:no_logo, :undersized_logos, :from, :till, :search, filter: {}, asset_class_ids: [], location_ids: [], job_function_ids: [], practice_ids: [])
    super
  end

  def create
    resource = resource_class.new(resource_params)
    authorize_resource(resource)

    if resource.save
      logotype = resource.logotype
      resource.update!(logo_width: logotype.width, logo_height: logotype.height) if logotype.file
      redirect_to(after_resource_created_path(resource), notice: translate_with_resource("create.success"))
    else
      render :new, locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }, status: :unprocessable_entity
    end
  end

  def update
    assign_new_attachment_from_params!
    assign_dimensions_of_new_attachment!
    Companies::AssociationTracking.new(params, current_user).call
    super
  end

  # After this method:
  #   requested_resource.changes #=> {"logotype"=>["file-1.png", "file-2.png"]}
  def assign_new_attachment_from_params!
    requested_resource.assign_attributes(resource_params.slice(:logotype))
    # resource_params.slice("logotype") #=> #<ActionController::Parameters {"logotype"=>#<ActionDispatch::Http::Up...}
  end

  # After this method:
  #   requested_resource.changes #=> { "logotype"=>["file-1.png", "file-2.png"],
  #                                    "logo_width"=>[354, 1120], "logo_height"=>[111, 926] }
  def assign_dimensions_of_new_attachment!
    return unless requested_resource.attribute_changed? :logotype
    return unless requested_resource.logotype.file
    return unless requested_resource.logotype.respond_to?(:width)
    return unless requested_resource.logotype.width.positive?

    requested_resource.assign_attributes(
      logo_width:  requested_resource.logotype.width,
      logo_height: requested_resource.logotype.height,
    )
  end

  def scoped_resource
    filtered_params = params.require(FILTER_SCOPE).permit(:no_logo, :undersized_logos, :from, :till, :search, asset_class_ids: [], location_ids: [], job_function_ids: [], practice_ids: [])

    @search = ::Search.new(filtered_params)

    if @search.valid?
      ::Companies::Filter.new(@search).call
    else
      Company.order(:name)
    end
  rescue ActionController::ParameterMissing
    @search = ::Search.new

    Company.order(:name)
  end

  def after_resource_destroyed_path(_requested_resource)
    if at_companies_page? && filtering_pagination_or_search_applied?
      request.referer
    else
      { action: :index }
    end
  end

  def requested_index
    search_term = params[:search].to_s.strip

    resources = resource_class.where(is_request: true)
    resources = Administrate::Search.new(resources,
                                         dashboard_class,
                                         search_term).run
    resources = apply_collection_includes(resources)
    resources = order.apply(resources)
    resources = resources.page(params[:_page]).per(records_per_page)

    page = Administrate::Page::Collection.new(dashboard, order: order)
    @clients = Client.where(id: resources.pluck(:client_id))

    render "admin/companies/index", locals: {
      resources: resources,
      search_term: search_term,
      page: page,
      show_search_bar: false, # show_search_bar? # TODO: make search working, then turn it on
      path: url_for([:admin, resource_class.model_name.route_key.to_sym, :requested]),
      requested: true,
    }
  end

  def apply_request
    Company.update params.require(:id), is_request: false
    redirect_to admin_companies_requested_path
  end

  private

  def at_companies_page?
    request.referer.to_s.include? admin_companies_path
  end

  def filtering_pagination_or_search_applied?
    referrer_uri = URI.parse(request.referer) rescue URI.parse("")
    current_url_query = Rack::Utils.parse_query(referrer_uri.query) # like {"search"=>"Alps"} or {"_page"=>"2"}
    (%w[search _page] + filter_param_keys).any? { |key| current_url_query.include? key }
  end

  # @return Array like ["/admin/companies[asset_class_ids][]", ...]
  def filter_param_keys
    FILTER_ASSOCIATIONS.map { |model| "#{FILTER_SCOPE}[#{model.model_name.singular}_ids][]" }
  end

  def filter_resources(resources, search_term:)
    Administrate::Search.new(
      resources,
      dashboard,
      search_term,
    ).run
  end
end
