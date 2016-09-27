module SolidusWms
  module AdditionalOrdersActions
    extend ActiveSupport::Concern

    def export_xlsx
      tester_order_headers = ['Document Date', 'Sales Document Type', 'Purchase order number no', 'Sales Document', 'APC Local Depot No.', 'Delivery DLX No']

      Mime::Type.register 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', :xlsx

      xlsx_file_contents = Axlsx::Package.new do |p|
        p.workbook.add_worksheet(name: 'Tester orders') do |sheet|
          sheet.add_row tester_order_headers
          Spree::Order.all.each { |order| sheet.add_row [order.created_at, 'OR', '', '', '', ''] }
        end
      end.to_stream.string
      send_data(xlsx_file_contents,
                type:        Mime::XLSX,
                disposition: "attachment; filename=orders.xlsx")
    end
  end
end
