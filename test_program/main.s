.include "macro-syscalls.m"

.global main

main:
.data
	.align 2
	test1:			.asciz		"data\\test1.txt"		# Буфер для имени файла
	test2:			.asciz		"data\\test2.txt"		# Буфер для имени файла
	test3:			.asciz		"data\\test3.txt"		# Буфер для имени файла
	test4:			.asciz		"data\\test4.txt"		# Буфер для имени файла
	
	res1:			.asciz		"data\\res1.txt"		# Буфер для имени файла вывода
	res2:			.asciz		"data\\res2.txt"		# Буфер для имени файла вывода
	res3:			.asciz		"data\\res3.txt"		# Буфер для имени файла вывода
	res4:			.asciz		"data\\res4.txt"		# Буфер для имени файла вывода
.text	
	print_str("Тест1 - пустая строка")
	read_file(test1)
	find_min_max_char(a1)	
	str_min_max(a1, a2)				
	str_min_max(a1, a2)		
	mv	s10 a0		
	write_file(res1, a0)	
	newline
	mv	a0 s10			
	li	a7 4		
	ecall
	
	print_str("\n________________\n")
	
	print_str("Тест2 - один символ")
	read_file(test2)
	find_min_max_char(a1)	
	str_min_max(a1, a2)				
	str_min_max(a1, a2)		
	mv	s10 a0		
	write_file(res2, a0)	
	newline
	mv	a0 s10			
	li	a7 4		
	ecall
	
	print_str("\n________________\n")
	
	print_str("Тест3 - Hello World!")
	read_file(test3)
	find_min_max_char(a1)	
	str_min_max(a1, a2)				
	str_min_max(a1, a2)		
	mv	s10 a0		
	write_file(res3, a0)	
	newline
	mv	a0 s10			
	li	a7 4		
	ecall
	
	print_str("\n________________\n")
	
	print_str("Тест4 - текст")
	read_file(test4)
	find_min_max_char(a1)	
	str_min_max(a1, a2)				
	str_min_max(a1, a2)		
	mv	s10 a0		
	write_file(res4, a0)	
	newline
	mv	a0 s10			
	li	a7 4		
	ecall
		
	exit				# Завершаем программу
