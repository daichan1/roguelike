def route_select(route_decision)
  puts "ルートを選択してください(1:左 2:真ん中 3:右)"
  route_number = gets.to_i
  if ROUTE_CANDIDATE.include?(route_number)
    route_decision = ROUTING
  else
    puts "1,2,3のどれかを入力してください"
  end
  route_decision
end
