require 'rails_helper'

RSpec.describe AgreementPolicy do
  let(:admin) { create(:user, :admin) }
  let(:landlord) { create(:user, :landlord) }
  let(:tenant) { create(:user, :tenant) }
  let(:other_user) { create(:user) }
  let(:property) { create(:property, landlord: landlord) }
  let(:agreement) { create(:agreement, property: property, landlord: landlord, tenant: tenant) }

  subject { described_class }

  describe 'create?' do
    it 'allows access for admin' do
      expect(subject.new(admin, Agreement.new)).to permit_action(:create)
    end

    it 'allows access for landlord' do
      expect(subject.new(landlord, Agreement.new)).to permit_action(:create)
    end

    it 'denies access for tenant' do
      expect(subject.new(tenant, Agreement.new)).to forbid_action(:create)
    end

    it 'denies access for other users' do
      expect(subject.new(other_user, Agreement.new)).to forbid_action(:create)
    end
  end

  describe 'show?' do
    it 'allows access for admin' do
      expect(subject.new(admin, agreement)).to permit_action(:show)
    end

    it 'allows access for landlord' do
      expect(subject.new(landlord, agreement)).to permit_action(:show)
    end

    it 'allows access for tenant' do
      expect(subject.new(tenant, agreement)).to permit_action(:show)
    end

    it 'denies access for other users' do
      expect(subject.new(other_user, agreement)).to forbid_action(:show)
    end
  end

  describe 'index?' do
    it 'allows access for admin' do
      expect(subject.new(admin, Agreement)).to permit_action(:index)
    end

    it 'allows access for landlord' do
      expect(subject.new(landlord, Agreement)).to permit_action(:index)
    end

    it 'allows access for tenant' do
      expect(subject.new(tenant, Agreement)).to permit_action(:index)
    end

    it 'denies access for other users' do
      scope = Pundit.policy_scope!(other_user, Agreement)
      expect(scope).to be_empty
    end
  end

  describe 'update?' do
    it 'allows access for admin' do
      expect(subject.new(admin, agreement)).to permit_action(:update)
    end

    it 'allows access for landlord' do
      expect(subject.new(landlord, agreement)).to permit_action(:update)
    end

    it 'denies access for tenant' do
      expect(subject.new(tenant, agreement)).to forbid_action(:update)
    end

    it 'denies access for other users' do
      expect(subject.new(other_user, agreement)).to forbid_action(:update)
    end
  end

  describe 'destroy?' do
    it 'allows access for admin' do
      expect(subject.new(admin, agreement)).to permit_action(:destroy)
    end

    it 'denies access for landlord' do
      expect(subject.new(landlord, agreement)).to forbid_action(:destroy)
    end

    it 'denies access for tenant' do
      expect(subject.new(tenant, agreement)).to forbid_action(:destroy)
    end

    it 'denies access for other users' do
      expect(subject.new(other_user, agreement)).to forbid_action(:destroy)
    end
  end

  describe 'scope' do
    let(:scope) { Pundit.policy_scope!(user, Agreement) }

    context 'for an admin' do
      let(:user) { admin }

      it 'includes all agreements' do
        expect(scope).to include(agreement)
      end
    end

    context 'for a landlord' do
      let(:user) { landlord }

      it 'includes agreements where the user is the landlord' do
        expect(scope).to include(agreement)
      end

      it 'does not include agreements where the user is not the landlord' do
        other_agreement = create(:agreement)
        expect(scope).not_to include(other_agreement)
      end
    end

    context 'for a tenant' do
      let(:user) { tenant }

      it 'includes agreements where the user is the tenant' do
        expect(scope).to include(agreement)
      end

      it 'does not include agreements where the user is not the tenant' do
        other_agreement = create(:agreement)
        expect(scope).not_to include(other_agreement)
      end
    end

    context 'for other users' do
      let(:user) { other_user }

      it 'does not include any agreements' do
        expect(scope).to be_empty
      end
    end
  end
end