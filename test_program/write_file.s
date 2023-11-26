.include "macro-syscalls.m"

.global write_file

write_file:
.eqv	 RESULT_SIZE 40	# Размер буфера для результата
.data
	error_name:	.asciz "Неверное имя файла!"
.text
	push(ra)			
	push(s1)
	push(s0)
	push(a1)			# Сохраняем адрес текста, чтобы не потерять его при выполнении open
	open(WRITE_ONLY)
	li	s1 -1			# Проверка на корректное открытие
    	beq	a0 s1 er_name		# Ошибка открытия файла
   	mv   	s0 a0       		# Сохранение дескриптора файла
	# Запись информации в открытый файл
   	li   	a7, 64       		# Системный вызов для записи в файл
    	mv   	a0, s0 		# Дескриптор файла
    	pop(a1)  			# Адрес буфера записываемого текста
   	li   	a2, RESULT_SIZE    	# Размер записываемой порции из регистра
   	ecall             		# Запись в файл
   	
   	pop(s0)
   	pop(s1)
   	pop(ra)
   	ret
   	
# Сообщение об ошибочном имени файла      
er_name:
    la		a0 error_name			
    li		a1 0
    li		a7 55
    ecall
    exit
