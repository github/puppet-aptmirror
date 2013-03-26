require 'spec_helper'

describe 'aptmirror::source' do
  let(:title) { 'foo' }

  context 'passing a string to distributions' do
    let(:params) {
      {
        :distributions => 'precise',
        :components    => ['main'],
      }
    }

    it 'should fail input validation' do
      expect { subject }.to raise_error(Puppet::Error, /is not an Array/)
    end
  end

  context 'passing an array to distributions' do
    let(:params) {
      {
        :distributions => ['precise'],
        :components    => ['main'],
      }
    }

    it 'should pass input validation' do
      expect { subject }.to_not raise_error
    end
  end

  context 'passing a string to components' do
    let(:params) {
      {
        :distributions => ['precise'],
        :components    => 'main',
      }
    }

    it 'should fail input validation' do
      expect { subject }.to raise_error(Puppet::Error, /is not an Array/)
    end
  end

  context 'passing an array to distributions' do
    let(:params) {
      {
        :distributions => ['precise'],
        :components    => ['main'],
      }
    }

    it 'should pass input validation' do
      expect { subject }.to_not raise_error
    end
  end

  [:clean, :amd64, :i386, :source].each do |param|
    context "passing a string to #{param.to_s}" do
      let(:params) {
        {
          :distributions => ['precise'],
          :components    => ['main'],
          param          => 'true',
        }
      }

      it 'should fail input validation' do
        expect { subject }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end

    context "passing a boolean to #{param.to_s}" do
      let(:params) {
        {
          :distributions => ['precise'],
          :components    => ['main'],
          param          => true,
        }
      }

      it 'should fail input validation' do
        expect { subject }.to_not raise_error
      end
    end
  end
end
