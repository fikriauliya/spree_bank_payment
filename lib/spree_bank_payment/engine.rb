module SpreeBankPayment
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_bank_payment'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer "spree.bank_payment.payment_methods", :after => "spree.register.payment_methods"  do |app|
      puts "Initialize Bank Transfer payment method"
      app.config.spree.payment_methods << Spree::PaymentMethod::BankPayment
    end
  end
end
