for goal_amount = false

  for each

weekly_balance = 3
goal_amount = 8
goal_target = 12

if goal_amount < goal_target

  diff =  goal_target - goal_amount

  while weekly_balance != 0 # POSSIBLEMENT INFINI. Mais tu as besoin de récurrence avec tes différents goals.
    if weekly_balance < diff
      goal_amount += weekly_balance
      weekly_balance = 0
    else
      weekly_balance -= diff
      goal_amount += diff
  end
end

puts goal_amount
puts weekly_balance
puts diff
