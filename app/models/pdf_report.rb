# encoding: utf-8
class PdfReport < Prawn::Document
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper
  include ApplicationHelper

  #mock for cancan
  def self.find(id)
    nil
  end

  def to_pdf(report)
    font "Helvetica"
    font_size 20
    text "Relatório de #{report.description}", :align => :center, :style => :bold
    move_down 20

    header = []

    report.fields.split(',').each do |field|
      field = Field.find(field)
      header << "#{field.description}"
    end

    body = []
    fields = report.fields.split(',')
    lines = []

    body << header

    fields.each do |field|
      field = Field.find(field)

      eval(field.data_table.name.camelize).all.each_with_index do |fact, i|
        lines[i] = [] if lines[i].nil?
        lines[i] << "#{fact.send(field.description.to_sym)}"
      end
    end
    lines.each do |line|
      body << line
    end

    font_size 9
    bounding_box([25,bounds.top-50], :width => 500, :height => 500) do
      table body, :width => 500, :cell_style => { :border_width => 0.5 } do
        style(row(0), :background_color => '888888', :font_style => :bold, :align => :center)
      end
    end

    font_size 10

    bounding_box([bounds.right - 50,bounds.bottom], :width => 400, :height => 20) do
      pagecount = page_count
      text "#{pagecount}"
    end

    render
  end
end
