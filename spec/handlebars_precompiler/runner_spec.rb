require 'spec_helper'
require 'command'
require 'runner'

module HandlebarsPrecompiler
  describe Runner do
    include FileUtils

    let :config do
      stub :config, {
        template_root: Pathname.new(File.dirname(__FILE__)).join('../fixtures'),
        output_file:   Pathname.new(File.dirname(__FILE__)).join('../fixtures/output.js'),
        extension:     :handlebars
      }
    end

    let :command do
      lambda { }
    end

    subject :reloader do
      Runner.new
    end

    before do
      reloader.config  = config
      reloader.command = command

      rm Dir[config.template_root.join('*.handlebars')]
      touch config.output_file
    end

    describe :updated? do
      it 'initial state is updated' do
        expect(reloader).to be_updated
      end

      it 'is updated when a file is added' do
        expect(reloader).to be_updated

        expect do
          touch config.template_root.join('added.handlebars')
        end.to change {
          reloader.updated?
        }.from(false).to(true)
      end

      it 'is updated when a file is removed' do
        touch config.template_root.join('added.handlebars')
        expect(reloader).to be_updated

        expect do
          rm config.template_root.join('added.handlebars')
        end.to change {
          reloader.updated?
        }.from(false).to(true)
      end

      it 'is updated when a file is updated' do
        touch config.template_root.join('added.handlebars')
        expect(reloader).to be_updated

        expect do
          sleep 1
          touch config.template_root.join('added.handlebars')
        end.to change {
          reloader.updated?
        }.from(false).to(true)
      end

      it 'is not updated if no files were changed' do
        expect(reloader).to be_updated
        expect(reloader).to_not be_updated
      end

      it 'is updated if the output file is not there' do
        rm config.output_file
        expect(reloader).to be_updated
      end
    end

    describe :run do
      it 'calls the block when updated' do
        subject.should_receive(:updated?).and_return(true)
        command.should_receive(:call)

        reloader.run
      end

      it 'does not call the block if not updated' do
        subject.should_receive(:updated?).and_return(false)
        command.should_not_receive(:call)

        reloader.run
      end
    end
  end
end
