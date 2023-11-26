.include "macro-syscalls.m"
.global int_to_string

int_to_string:
.data
    .align 2
    new_int_reverse:    .space    5
    new_int:            .space    5
.text
    push(ra)
    push(t1)
    push(t2)
    push(t3)
    push(t4)
    push(t6)
    
    la    t0 new_int_reverse   # Указатель на буфер для обратной строки
    mv    t1 a5                # Сохранить указатель на число
    la    t6 new_int           # Указатель на буфер для результата
    li    t3 10                # Инициализируем для деления 
    li    t2 0                 # Счетчик символов в строке   

string_loop:
    addi  t2 t2 1
    remu  t4 t1 t3             # Остаток от деления
    addi  t4 t4 '0'            # Преобразовать в ASCII
    sb    t4 (t0)              # Сохранить символ в t0
    divu  t1 t1 t3             # Разделить на 10
    addi  t0 t0 1              
    bnez  t1 string_loop       # Повторить, если число еще не ноль
    
reverse_loop:
    addi  t2 t2 -1
    addi  t0 t0 -1
    lb    t4 (t0)              # Загрузить символ
    sb    t4 (t6)              # Загрузить символ в буфер результата
    addi  t6 t6 1              
    bnez  t2 reverse_loop      # Повторить, если строка еще не завершена
    
    sb    zero (t6)		   
    
    la    a5 new_int		   # Возвращаем число в виде строки в регитсре a5	
    
    pop(t6)
    pop(t4)
    pop(t3)
    pop(t2)
    pop(t1)
    pop(ra)
    ret                        # Вернуться из функции
