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
        date_yyyy_mm_dd(r.start_date),
        date_yyyy_mm_dd(r.end_date),
      ]
    end
    rows
  end

  def date_yyyy_mm_dd(date)
    date[0..9]
  end
end
