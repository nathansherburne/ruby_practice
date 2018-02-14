require_relative 'discrete_distribution_sampler'

class DiscreteDistributionSamplerTester
    def initialize(cmf_pairs = [[1,0.25], [2,0.75]], alpha = 0.20)
        @alpha = alpha
        @dds = DiscreteDistributionSampler.new(cmf_pairs)
    end

    def test
        if compare_pmfs(get_samples(1000)) > @alpha
            false
        else
            true
        end
    end

    def get_samples(n)
        result = []
        (1..n).each do |i|
            result.append(@dds.get_sample)
        end
        return result
    end

    def compare_pmfs(arr)
        error = 0
        orig_pmf = @dds.cmf_pairs
        orig_pmf.each do |value, weight|
            p_i = arr.count(value)*1.0 / arr.length
            error += (weight - p_i).abs
        end
        return error
    end
end
