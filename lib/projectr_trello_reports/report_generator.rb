class ReportGenerator
  def csv(board_id, completed_cards)
    csv = generate_csv(completed_cards)
    report_name = "#{board_id}_report.csv"
    File.write(report_name, csv)
    report_name
  end

  private

  def generate_csv(records)
    headers = [
      "Start Date",
      "Finish Date",
    ]
    content = headers.join(',') + "\n"

    rows = prepare_rows(records)
    rows.each do |row|
      content << row.map {|field| "\"#{field}\""}.join(',') + "\n"
    end

    content
  end

  def prepare_rows(records)
    rows = []
    records.each do |r|
      rows << [
        r.start_date,
        r.end_date,
      ]
    end
    rows
  end
end
