.include "macro-syscalls.m"
# s1 - min
# s2 - max
.global find_min_max_char

find_min_max_char:

.data	
	.align 2
	#str: 		.asciz "Hello"
	str_min:	.word 
	str_max:	.word
.text	
	push(ra)
	
	mv	t0 a0		#Передаем строку из файла
	
	# Предцикловая загрузка символов для отлова ошибок
	lb	t1 (t0)
	addi	t0 t0 1
	beqz 	t1 error			# Пустая строка
	lb	t2 (t0)
	addi	t0 t0 1
	beqz 	t2 error2			# Строка с одним символом
	blt 	t1, t2, first_min 		# if t1 < t2
	bgt 	t1, t2, second_min 		# if t1 > t2
back:

loop:
	lb	t1 (t0)	
	beqz 	t1 exit
	blt 	t1, s1, new_min 		# if t1 < s1
	bgt 	t1, s2, new_max 		# if t1 > s2
	back_loop:
	addi	t0 t0 1
	j	loop
	
exit:	
	mv	a1 s1			# Возвращаем min в a2
	mv	a2 s2			# Возвращаем max в a3
	pop(ra)
	ret		

new_min:
	mv	s1 t1
	j	back_loop
new_max:	
	mv	s2 t1
	j	back_loop
			
first_min:
	mv	s1 t1
	mv	s2 t2
	j	back
	
second_min:
	mv	s1 t2
	mv	s2 t1
	j	back
				
error2:
	# Строка с одним символом
	# Возвращаем этот символ, как минимальный и максимальный
	mv	a1 t1			
	mv	a2 t1
	pop(ra)
	ret			

error:
	# Пустая строка
	# Возвращаем null
	li	a1 0
	li	a2 0
	pop(ra)
	ret
