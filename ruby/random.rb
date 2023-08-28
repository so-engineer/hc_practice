# frozen_string_literal: true

group = %w[A B C D E F]

a_group = group.sample(rand(2..3))
b_group = group - a_group
p a_group
p b_group
