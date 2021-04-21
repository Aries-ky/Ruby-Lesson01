require "csv"
text = []
line = 0
puts "1(新規でメモを作成) 2(既存のメモ編集する)"
memo_type = gets.to_i
if memo_type == 1 then
  puts "新規でメモを作成"
  loop{
    input = gets.chomp
    if input == "exit" then
      break
    end
    text[line] = input
    line += 1
  }
  puts "保存するタイトルを入力してください。保存しない場合は0を入力"
  title = gets.chomp
  if title == "0" then
    puts "文章を破棄して終了します。"
    exit
  end
  title = title + ".csv" 
  CSV.open(title,"w") do |csv|
    text.each do |fo|
      csv << [fo]
    end
  end
  puts "保存しました"
elsif memo_type == 2
  puts "既存のメモ編集します"
  puts "読み込むファイル名を入力してください.csvは入力不要です"
  title = gets.chomp + ".csv"
  CSV.foreach(title) do |csv_line|
    puts csv_line
    text[line] = csv_line
    line += 1
  end
  loop{
    puts "編集する行数を入力してください"
    puts "-1入力で文末から新規追加　-2 で上書き保存して終了します"
    edit = gets.to_i
    if edit == -1  || line < edit then
      break
    elsif edit == -2 then
      CSV.open(title,"w") do |csv|
        text.each do |fo|
          csv << [fo]
        end
      end
      puts "保存しました"
      exit
    else
      puts text[edit]
      input = gets.chomp
      text[edit] = input
    end
  }
  puts "文末から追加編集中 exit 入力で終了"
  loop{
    input = gets.chomp
    if input == "exit" then
      break
    end
    text[line] = input
    line += 1
  }
  CSV.open(title,"w") do |csv|
    text.each do |fo|
      csv << [fo]
    end
  end
  puts "保存しました"
else
  puts "規定数字以外が入力されました"
end
puts "処理を終了"