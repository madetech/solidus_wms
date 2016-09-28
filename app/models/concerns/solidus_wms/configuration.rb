module SolidusWms
  class Configuration < ::Spree::Preferences::Configuration

    attr_writer :order_xls_export_class
    def order_xls_export_class
      @order_xls_export_class
    end
  end
end
