.include "macro-syscalls.m"

.global main

main:
.eqv	FILE_NAME_SIZE 256		# Размер буфера для имени файла
.data
	.align 2
	file_name:	.space		FILE_NAME_SIZE	# Буфер для имени файла
	file_name_out:	.space		FILE_NAME_SIZE	# Буфер для имени файла вывода
.text
	InputDialogString("Введите путь к файлу для чтения", file_name, FILE_NAME_SIZE)
	read_file(file_name)
	
	find_min_max_char(a1)		# Вызываем подпрограмму для поиска минимального и максимального элементов
					# строка находится в регисре a1
					
	str_min_max(a1, a2)		# Создаем строку ответ передавая минимальный и максимальный элемент
	mv	s10 a0			# Сохраняем результат на будущее
	
	InputDialogString("Введите путь к файлу для записи", file_name_out, FILE_NAME_SIZE)
	write_file(file_name_out, a0)	# Записываем ответ в файл и передаем указатель на результат
	
	ask_to_user			# Спрашиваем у пользователя хочет ли он вывести результат в консоль
	mv	a0 s10			# Восстанавливаем адресс строки в a0
	li	a7 4		
	ecall
	
without_console:
	
	exit				# Завершаем программу
