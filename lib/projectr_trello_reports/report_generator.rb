class ReportGenerator
  def csv(board_id, completed_cards)
    sorted_cards = sort_cards(completed_cards)
    csv = generate_csv(sorted_cards)
    report_name = "#{board_id}_report.csv"
    File.write(report_name, csv)
    report_name
  end

  private

  def generate_csv(records)
    headers = [
      "Started",
      "Done",
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

  def sort_cards(cards)
    cards.sort_by do |card|
      [DateTime.parse(card.start_date), DateTime.parse(card.end_date)]
    end
  end
end
