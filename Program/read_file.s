.include "macro-syscalls.m"

.global read_file

read_file:
.eqv    TEXT_SIZE 512	# Размер буфера для текста

.data
	strbuf:	.space TEXT_SIZE		# Буфер для читаемого текста
.text
    push(ra)
    open(READ_ONLY)
    li		s1 -1			# Проверка на корректное открытие
    beq	a0 s1 er_name		# Ошибка открытия файла
    mv   	s0 a0       		# Сохранение дескриптора файла

    # Выделение начального блока памяти для для буфера в куче
    allocate(TEXT_SIZE)		# Результат хранится в a0
    mv 	s3, a0			# Сохранение адреса кучи в регистре
    mv 	s5, a0			# Сохранение изменяемого адреса кучи в регистре
    li		s4, TEXT_SIZE		# Сохранение константы для обработки
    mv		s6, zero		# Установка начальной длины прочитанного текста
    
read_loop:
    # Чтение информации из открытого файла
    read_addr_reg(s0, s5, TEXT_SIZE) # чтение для адреса блока из регистра
    
    # Проверка на корректное чтение
    beq	a0 s1 er_read		# Ошибка чтения
    mv   	s2 a0       		# Сохранение длины текста
    add 	s6, s6, s2		# Размер текста увеличивается на прочитанную порцию
    # При длине прочитанного текста меньшей, чем размер буфера,
    # необходимо завершить процесс.
    bne	s2 s4 end_loop
    # Иначе расширить буфер и повторить
    allocate(TEXT_SIZE)		# Результат здесь не нужен, но если нужно то...
    add	s5 s5 s2		# Адрес для чтения смещается на размер порции
    b read_loop			# Обработка следующей порции текста из файла
end_loop:

    # Закрытие файла
    close(s0)
    
    # Установка нуля в конце прочитанной строки
    mv		t0 s3		# Адрес буфера в куче
    add 	t0 t0 s6	# Адрес последнего прочитанного символа
    addi 	t0 t0 1	# Место для нуля
    sb		zero (t0)	# Запись нуля в конец текста
    
    
    # TODO: Передавать в регист а точку, откуда мы будем возвращать значения из подпрограммы
    mv		a1 s3		# Возвращаем результат в a1
    pop(ra)
    ret
  
# Сообщение об ошибочном имени файла      
er_name:
    print_str("Incorrect file name\n")
    exit
    
# Сообщение об ошибочном чтении    
er_read:
    print_str("Incorrect read operation\n")
    exit 
