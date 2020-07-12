def generate_random_num
    return rand(File.open('5desk.txt').readlines.length)
end

def calc_num_chances(word)
    unique_letters=[]
    for i in 0..word.length-1
        unique_letters.push(word[i]) unless unique_letters.include?word[i]
    end
    return unique_letters.length+5

end

def get_input
    puts "You have #{$num_chances} chances remaining"
    ch=''
    while ch == ''
        print "Enter your choice : "
        ch=gets.chomp.downcase
        if ch.bytes[0] < 97 or ch.bytes[0] > 122 or ch.bytes.length > 1
            ch=''
        end
    end
    for i in 0..$word.length-1
        if $word[i]==ch
            $answer[i]=ch
        end
    end
    puts "\n"
end

def display_answer
    for i in 0..$answer.length-1
        print $answer[i]+" "
    end
    print "\n\n"
end

def game_not_over?
    if !($answer.include?"_")
        display_answer
        puts "Congratualtions. You won."
        false
    elsif $num_chances==0
        display_answer
        puts "Sorry you lost. You ran out of chances."
        puts "The correct word was #{$word}"
        false
    else
        true
    end
end

file=File.open('5desk.txt')
$word=""
$num_chances=0
$answer=[]

puts "Guess the right word to win the game\n\n"
while $word.length < 5 or $word.length > 12
    random=generate_random_num
    File.open('5desk.txt').each_with_index do |line,index|
        if index == random
            $word = line.strip!.downcase
        end
    end
end

$num_chances=calc_num_chances($word)
for i in 0..$word.length-1
    $answer.push("_")
end

while game_not_over?
    display_answer
    get_input
    $num_chances -= 1
end