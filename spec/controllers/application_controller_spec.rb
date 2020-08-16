require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # create test user
  let!(:user) { create(:user) }
  # set headers for authorization
  let(:invalid_headers_by_ip) { { 'Authorization' => token_generator(user.id, '1.1.1.1') } }
  let(:headers) { { 'Authorization' => token_generator(user.id, '0.0.0.0') } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  describe '#authorize_request' do
    context 'when auth token is passed' do
      before { allow(request).to receive(:headers).and_return(headers) }

      # private method authorize_request returns current user
      it 'sets the current user' do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context 'when auth token is not passed' do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it 'raises MissingToken error' do
        expect { subject.instance_eval { authorize_request } }
          .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end

    context 'when auth token has wrong IP' do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers_by_ip)
      end

      it 'raises InvalidIp error' do
        expect { subject.instance_eval { authorize_request } }
          .to raise_error(ExceptionHandler::InvalidIp, /Invalid token/)
      end
    end
  end
end
