module RspecTestHelpers
  def parsed_response_json(response)
    JSON.parse(response.body).with_indifferent_access
  end
end
