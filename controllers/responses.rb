# frozen_string_literal: true

def build_ue_response(message)
  halt UE, { status_code: UE, message: message }.to_json
end

def build_ok_response(data)
  { status_code: OK, data: data }.to_json
end
