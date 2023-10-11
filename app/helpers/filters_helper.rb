module Admin::Companies::FiltersHelper
    def value_for_filter_param_key(key)
      params.dig(Admin::CompaniesController::FILTER_SCOPE, key.to_s)
    end
  
    def is_checkbox_checked?(key)
      !!ActiveModel::Type::Boolean.new.cast(value_for_filter_param_key(key))
    end
  
    def company_filters_hidden?
      selected_values = 0
      non_selected_values = ["", [""], nil, false]
      Admin::CompaniesController::PARAMS_IN_COMPANIES_FILTER.each do |param|
        value = params.dig(:filter, param)
        selected_values += 1 unless non_selected_values.any?(value)
      end
  
      selected_values < 1
    end
end
  