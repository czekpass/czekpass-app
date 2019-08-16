require 'rqrcode'
# require 'barby'
# require 'barby/barcode'
# require 'barby/barcode/qr_code'
# require 'barby/outputter/png_outputter'

class PerksController < ApplicationController
  def show
    @perk = Perk.find(params[:id])
    qrcode = RQRCode::QRCode.new("http://github.com/")

    @qr = qrcode.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6
    )

    # @qr2 = generate_qr('test')

  end

  # private
  # def generate_qr(text)

  #   barcode = Barby::QrCode.new(text, level: :q, size: 5)
  #   @output = Base64.encode64(barcode.to_png({ xdim: 5 }))
# end

end
