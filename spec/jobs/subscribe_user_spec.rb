require 'rails_helper'

describe SubscribeUserJob, type: :job do
  let!(:user) { create(:user) }
  let(:suscribe_user_job) { SubscribeUserJob.new(user) }

  it 'does subscribe user' do
    expect(NotificationService).to receive(:subscribe_user).with(user.email)
    suscribe_user_job.perform(user)
  end
end
