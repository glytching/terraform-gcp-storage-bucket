class TestInputsReader
    attr_reader :test_inputs

    def initialize(file)
        @test_inputs = JSON.parse(file, symbolize_names: true)
    end

    def method_missing(method_name, *arguments, &block)
        return super unless test_inputs.key?(method_name)
        val = test_inputs.fetch(method_name).fetch(:value)
    end

    # get a value for the given key, or "" if there is no such key
    def get(key_name)
        val = get_or_default(key_name, "")
    end

    # get a value for the given key, or <default_value> if there is no such key
    def get_or_default(key_name, default_value)
        if test_inputs.has_key? key_name.to_sym
            val = test_inputs.fetch(key_name.to_sym).fetch(:value)
        else
            val = default_value
        end
    end
end