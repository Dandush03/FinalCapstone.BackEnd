# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication test suite
  describe 'POST /api/auth/login' do
    # create test user
    let!(:user) { create(:user) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials_by_email) do
      {
        login: user.email,
        password: user.password
      }.to_json
    end
    let(:valid_credentials_by_username) do
      {
        login: user.username,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        login: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # set request.headers to our custon headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    # returns auth token when request is valid
    context 'When request is valid' do
      before { post '/api/auth/login', params: valid_credentials_by_email, headers: headers }
      it 'returns an authentication token for a email validation' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is valid' do
      before { post '/api/auth/login', params: valid_credentials_by_username, headers: headers }

      it 'returns an authentication token for a username validation' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid' do
      before { post '/api/auth/login', params: invalid_credentials, headers: headers }
      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end

  describe 'POST /api/auth/signup' do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) do
      attributes_for(:user, password_confirmation: user.password)
    end
    context 'when valid request' do
      before { post '/api/auth/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/api/auth/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      # rubocop: disable Layout/LineLength
      it 'returns failure message' do
        expect(json['message'])
          .to match("Validation failed: Password can't be blank, Password is too short (minimum is 6 characters), Full name can't be blank, Username can't be blank, Email can't be blank")
      end
    end
    # rubocop: enable Layout/LineLength
  end
end
# rubocop: enable Metrics/BlockLength
