module DataHelper
  def review_data
    @code_reviews.sort_by(&:date).map do |review|
      [
        {
          date: review.date,
          price: review.loc,
          symbol: 'LoC'
        },
        {
          date: review.date,
          price: review.smells,
          symbol: 'Smells'
        },
        {
          date: review.date,
          price: review.tests,
          symbol: 'Tests'
        },
        {
          date: review.date,
          price: review.failures,
          symbol: 'Failures'
        },
        {
          date: review.date,
          price: review.coverage,
          symbol: 'Coverage'
        }
      ]
    end.flatten.to_json.html_safe
  end
end
