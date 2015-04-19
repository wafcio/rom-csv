require 'spec_helper'
require 'virtus'

describe 'Commands / Create' do
  subject(:rom) { setup.finalize }

  let(:original_path) { File.expand_path('./spec/fixtures/users.csv') }
  let(:path) { File.expand_path('./spec/fixtures/testing.csv') }

  # If :csv is not passed in the repository is named `:default`
  let(:setup) { ROM.setup(:csv, path) }

  subject(:users) { rom.commands.users }

  before do
    FileUtils.copy(original_path, path)

    setup.relation(:users) do
      def by_id(id)
        restrict(user_id: id)
      end
    end

    class User
      include Virtus.model

      attribute :id, Integer
      attribute :name, String
      attribute :email, String
    end

    setup.mappers do
      define(:users) do
        model User
        register_as :entity
      end
    end

    setup.commands(:users) do
      define(:update)
    end
  end

  it 'updates everything when there is no original tuple' do
    result = users.try do
      users.update.by_id(1).set(email: 'tester@example.com')
    end

    # expect(result.value.to_a).to match_array([{ id: 1, name: 'Peter' }])
  end

  # it 'updates when attributes changed' do
  #   # result = users.try do
  #   #   users.update.by_id(piotr[:id]).change(piotr).to(peter)
  #   # end
  #
  #   # expect(result.value.to_a).to match_array([{ id: 1, name: 'Peter' }])
  # end

  # it 'does not update when attributes did not change' do
  #   # piotr_rel = double('piotr_rel').as_null_object
  #
  #   # expect(relation).to receive(:by_id).with(piotr[:id]).and_return(piotr_rel)
  #   # expect(piotr_rel).not_to receive(:update)
  #
  #   # result = users.try do
  #   #   users.update.by_id(piotr[:id]).change(piotr).to(name: piotr[:name])
  #   # end
  #
  #   # expect(result.value.to_a).to be_empty
  # end
end
