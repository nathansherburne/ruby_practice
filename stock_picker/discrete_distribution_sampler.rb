class Array
    def multiply_by(x)
        collect { |n| n * x }
    end
end

class DiscreteDistributionSampler
    attr_accessor :cmf_pairs
    def initialize(cmf_pairs)
        @cmf_pairs = cmf_pairs
        @prob, @alias = generate_alias_table
    end

    def get_sample
        col = (rand * @prob.length).floor
        use_alias = rand > @prob[col][1]
        unless use_alias
            @prob[col][0]
        else
            @alias[col]
        end
    end

    def generate_alias_table
        prob, _alias = [], []
        norm_vw = get_normalized_weights
        gt, lt = norm_vw.partition { |w| w[1] >= 1 }
        while lt.length > 0
            lt_i = lt.pop
            gt_j = gt.pop
            unless gt_j == nil
                # Take from prob greater than 1 and add it to less than 1
                # so that every column has height 1.
                # If it becomes a less than 1 entry, add it to lt, else gt.
                if (gt_j[1] -= 1 - lt_i[1]) < 1
                    lt.append(gt_j)
                else
                    gt.append(gt_j)
                end
                _alias.append(gt_j[0])
            else
                # Due to floating point imprecision, a very small degree of 
                # error will build up as the subtractions are made. This
                # results in the last element having ~ 0.9999... weight
                # instead of a weight of 1.
                lt_i[1] = 1
            end
            prob.append(lt_i)
        end
        # If there are any items in gt, each prob must be equal to 1.
        # So just add them and nil alias
        prob += gt
        _alias += Array.new(gt.length, nil)
        return prob, _alias
    end

    def get_normalized_weights
        norm_w = @cmf_pairs.transpose[1].multiply_by(@cmf_pairs.length)
        return [@cmf_pairs.transpose[0], norm_w].transpose
    end
end
