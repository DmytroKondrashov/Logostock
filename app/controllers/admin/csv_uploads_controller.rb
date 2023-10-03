class Admin::CsvUploadsController < Admin::ApplicationController
    protect_from_forgery unless: -> { request.format.json? }
  
    # GET /csv_uploads/new
    def new
      @errors = Array(session[:errors]) and session[:errors] = nil
      @example_companies = Company.
        eager_load(:asset_classes, :job_functions, :locations, :practices).
        where.not(practices: nil).
        where.not(asset_classes: nil).
        where.not(job_functions: nil).
        where.not(locations: nil).
        order("RANDOM()").limit(3)
      super
    end
  
    # POST /csv_uploads
    def create
      @csv_upload = CsvUpload.new(file: params[:csv], user: current_user)
  
      unless @csv_upload.save
        session[:errors] = @csv_upload.errors.full_messages
        redirect_to %i[new admin csv_upload]
        return
      end
  
      response = ::ProcessCsv::FormatData.new(@csv_upload).call
  
      if response[:ok]
        render locals: { csv: response, user: current_user.id.to_json }
      else
        redirect_to [:admin, @csv_upload], alert: response[:message]
      end
    end
  
    # PATCH /csv_uploads/:id
    def update
      @csv_upload = CsvUpload.find params[:id]
      response = ::UploadCompanies::UpsertData.new(params[:csv_upload][:companies]).call
  
      if @csv_upload.update(
        companies_applied: response[:applied].to_json,
        companies_failed: response[:failed].to_json,
        companies_discarded: params[:csv_upload][:discarded],
      )
        redirect_to [:admin, @csv_upload]
      else
        redirect_to admin_csv_uploads_new_path, alert: @csv_upload.errors.full_messages.to_sentence
      end
    end
  
    def index_incorrect
      authorize_resource(resource_class)
      resources = scoped_resource
      resources = apply_collection_includes(resources)
      resources = order.apply(resources)
      resources = resources.page(params[:_page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)
  
      render :index,
             locals: {
               resources: resources,
               incorrect: true,
               page: page,
               show_search_bar: false,
             }
    end
  
    def show
      page = Administrate::Page::Show.new(dashboard, requested_resource)
  
      respond_to do |format|
        format.html do
          unless page.resource.companies_applied.nil?
            companies_applied = JSON.parse(page.resource.companies_applied)
            @companies = Company.where(name: companies_applied.values.pluck("company_name"))
          end
          @parsed_csv = CSV.parse(page.resource.csv_content)
          render locals: { page: page }
        end
  
        format.csv do
          send_data page.resource.csv_content,
                    filename: page.resource.csv_filename,
                    type: "text/csv",
                    disposition: "attachment"
        end
      end
    end
  
    def default_sorting_attribute
      :created_at
    end
  
    def default_sorting_direction
      :desc
    end
  end
  