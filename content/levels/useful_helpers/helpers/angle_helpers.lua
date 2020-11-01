local helpers = {}

function helpers.random_angle()
  return fmath.random_fixedpoint(0fx, fmath.tau())
end

function helpers.angle_from_ratio_of_tau(numerator, denominator)
  return fmath.tau() * fmath.from_fraction(numerator, denominator)
end

return helpers