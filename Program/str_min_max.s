.include "macro-syscalls.m"
.global str_min_max

# Создаем массив и посимвольно заполняем его, чтобы в конечно итого получить строку следующего вида:
# min: 32 - ' '
# max: 114 - 'r'
str_min_max:
.data	
	result:	.space 40
.text
	push(ra)
	
	la	a0 result
	
min:	li	s1 'm'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 'i'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 'n'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 ':'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 32
	sb	s1 (a0)
	addi	a0 a0 1
	
	# a5 - число	для передачи в подпрограмму
	mv	a5 a1 			
	jal	int_to_string		# Переходим в подпрограмму для преобразования числа в строку
loop_int_min:				# Цикл для записи полученного числа в результирующую строку
	lb	s1 (a5)
	beqz 	s1 end_int_min
	sb	s1 (a0)
	addi	a0 a0 1
	addi   a5 a5 1
	j	loop_int_min	
end_int_min:
	
	li	s1 32
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 '-'
	sb	s1 (a0)
	addi	a0 a0 1

	li	s1 32
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 '\''
	sb	s1 (a0)
	addi	a0 a0 1
	
	mv	s1 a1			# число, которое мы передали
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 '\''
	sb	s1 (a0)
	addi	a0 a0 1

	li	s1 '\n'
	sb	s1 (a0)
	addi	a0 a0 1
	
max:	li	s1 'm'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 'a'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 'x'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 ':'
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 32
	sb	s1 (a0)
	addi	a0 a0 1
	
	# a5 - число	для передачи в подпрограмму
	mv	a5 a2			# число, которое мы передали
	jal	int_to_string		# Переходим в подпрограмму для преобразования числа в строку
loop_int_max:				# Цикл для записи полученного числа в результирующую строку
	lb	s1 (a5)
	beqz 	s1 end_int_max
	sb	s1 (a0)
	addi	a0 a0 1
	addi   a5 a5 1
	j	loop_int_max
end_int_max:
	
	li	s1 32
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 '-'
	sb	s1 (a0)
	addi	a0 a0 1

	li	s1 32
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 '\''
	sb	s1 (a0)
	addi	a0 a0 1
	
	mv	s1 a2			# число, которое мы передали
	sb	s1 (a0)
	addi	a0 a0 1
	
	li	s1 '\''
	sb	s1 (a0)
	addi	a0 a0 1
								
	la	a0 result
	
	pop(ra)
	ret
	