require 'axlsx'

module SolidusWms
  module AdditionalOrdersActions
    extend ActiveSupport::Concern

    def export_xlsx
      exporter = Rails.application.config.order_xls_export_class.new

      Mime::Type.register 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', :xlsx

      send_data(xlsx_file_contents(exporter).to_stream.string,
                type: Mime::XLSX,
                disposition: "attachment; filename=orders.xlsx")
    end

    private

    def xlsx_file_contents(exporter)
      ::Axlsx::Package.new do |p|
        exporter.worksheets.each do |order_group|
          p.workbook.add_worksheet(name: order_group.fetch('name')) do |sheet|
            sheet.add_row order_group.fetch('headers')

            order_group.fetch('orders').each do |order|
              sheet.add_row order
            end
          end
        end
      end
    end
  end
end
