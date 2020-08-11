# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API Task', type: :request do
  # create test user
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:task) { create(:task) }
  # set headers for authorization
  let(:headers) { valid_headers }
  let(:invalid_headers) { valid_headers.except('Authorization') }
  # set test valid and invalid credentials
  let(:valid_credentials_by_email) do
    {
      login: user.email,
      password: user.password
    }.to_json
  end

  describe 'API #index' do
    context 'GET #index with valid credentials' do
      before do
        get '/api/tasks', params: {}, headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains a Task List' do
        json_response = JSON.parse(response.body)
        expect(json_response[0].keys).to match_array(
          %w[
            category_id
            created_at
            description
            end
            hours
            id
            minutes
            name
            seconds
            start
            updated_at
            user_id
          ]
        )
      end
    end

    context 'GET #index with invalid credentials' do
      before do
        get '/api/tasks', params: {}, headers: invalid_headers
      end

      it 'returns http invalid credential Msg' do
        expect(json['message']).to match(/Missing token/)
      end

      it 'returns http invalid credential Msg' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API #searcher' do
    context 'GET #searcher with valid credentials' do
      before do
        get '/api/searcher', params: {}, headers: headers
      end
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
  
      it 'JSON body response contains a Task List' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(
          %w[
            category_id
            created_at
            description
            end
            hours
            id
            minutes
            name
            seconds
            start
            updated_at
            user_id
          ]
        )
      end
    end
  
    context 'GET #searcher with invalid credentials' do
      before do
        get '/api/searcher', params: {}, headers: invalid_headers
      end
  
      it 'returns http invalid credential Msg' do
        expect(json['message']).to match(/Missing token/)
      end
  
      it 'returns http invalid credential Msg' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API #create' do
    context 'POST #create with valid credentials' do
      let(:task) { build(:task) }
      before do
        post '/api/tasks', params: { tasks: task }.to_json, headers: headers
      end
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'POST #create with invalid credentials' do
      before do
        post '/api/tasks', params: {}, headers: invalid_headers
      end

      it 'returns http invalid credential Msg' do
        expect(json['message']).to match(/Missing token/)
      end

      it 'returns http invalid credential Msg' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API #update' do
    context 'PATCH #update with valid credentials' do
      before do
        time = Time.now
        time = time.to_i * 1000
        patch "/api/tasks/#{task.id}", params: { task: { end: time } }.to_json, headers: headers
      end
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'PATCH #update with invalid credentials' do
      before do
        patch "/api/tasks/#{task.id}", params: {}, headers: invalid_headers
      end

      it 'returns http invalid credential Msg' do
        expect(json['message']).to match(/Missing token/)
      end

      it 'returns http invalid credential Msg' do
        expect(response).to have_http_status(422)
      end
    end
  end

  

  describe 'API #seach_by_category' do
    let!(:task) { create_list(:task, 3) }
    context 'GET #search_by_category with valid credentials' do
      before do
        get '/api/searcher/by_category_date', params: {range: '1', category_id: category.id}, headers: headers
      end
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
  
      it 'JSON body response contains a Task List' do
        json_response = JSON.parse(response.body)
        expect(json_response[0].keys).to match_array(
          %w[
            category_id
            created_at
            description
            end
            hours
            id
            minutes
            name
            seconds
            start
            updated_at
            user_id
          ]
        )
      end
    end

    context 'GET #search_by_category with invalid credentials' do
      before do
        get '/api/searcher/by_category_date', params: {}, headers: invalid_headers
      end

      it 'returns http invalid credential Msg' do
        expect(json['message']).to match(/Missing token/)
      end

      it 'returns http invalid credential Msg' do
        expect(response).to have_http_status(422)
      end
    end

  end
end
